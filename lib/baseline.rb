require 'rubygems'
require 'active_support/inflector'
require 'optparse'
require 'fileutils'

class Baseline

  PASSWORD_REGEX = /^(?=.*?[0-9])(?=.*?[A-Z])(?=.*?[a-z])\S+$/

  # constructor
  def initialize
    raise ArgumentError, "ProjectName is required" if ARGV.size < 1
    
    @opts = self.options(ARGV)
    
    raise ArgumentError, "#{@opts[:project_dir]} already exists." if File.exist?(@opts[:project_dir])
  end

  def options(args)
    options = {}

    baseline_dir = File.join(File.dirname(__FILE__),'..')
    project_base = File.expand_path(File.join(baseline_dir,".."))
    options[:resource_dir] = File.expand_path(File.join(baseline_dir,"resources"))
    options[:project_name] = args[0]
    options[:simulator] = "capybara"

    parser = OptionParser.new do |o|
      o.set_summary_indent('  ')
      o.banner =    "Usage: #{File.basename($0)} [options] ProjectName"
      o.define_head "Baseline Rails setup"
      o.separator ""
      o.separator "options"
      o.on("-b","--basedir BASE_DIRECTORY", String, "Specify a project base directory. Defaults to parent of Baseline install dir.") { |basedir| project_base = basedir }
      o.on("--webrat", "Use webrat instead of capybara") { options[:simulator] = "webrat" }
      o.on("-h", "--help", "Show this message.") { puts o; exit }
    end
    
    parser.parse!(args)
    options[:project_dir] = File.join(project_base,options[:project_name].underscore)
    options
  end

  def generate_password
    #avoid confusion of 1 vs l, and 0 vs O
    chars = ("a".."k").to_a + ("m".."z").to_a + ("A".."N").to_a + ("P".."Z").to_a + ("2".."9").to_a
    until (pwd = Array.new(16).collect{chars[rand(chars.size)]}.join) =~ PASSWORD_REGEX do ; end
    pwd
  end

  def generate!
    # Setup a default environment
    system("rails #{@opts[:project_dir]}")
    Dir.chdir(@opts[:project_dir])
    FileUtils.cp(File.join(@opts[:resource_dir], "gitignore"),File.join(@opts[:project_dir],".gitignore"))
    system("git init ; git add .gitignore ; git add * ; git commit -m 'Default rails install'")

    # Edit database settings
    File.open(File.join(@opts[:project_dir],"config","database.yml"), "r+") do |f|
      lines = f.readlines
      new = lines[0,lines.index("production:\n") + 1]
      new << "  adapter: mysql\n"
      new << "  encoding: utf8\n"
      new << "  database: #{@opts[:project_name].underscore}_production\n"
      new << "  username: #{@opts[:project_name].underscore}\n"
      new << "  password: #{generate_password}\n"
      new << "  socket: /var/run/mysqld/mysqld.sock\n"
      f.pos = 0
      f.print new
      f.truncate(f.pos)
    end
    system("git add config/database.yml ; git commit -m 'Production database settings'")

    # Setup RSpec and Cucumber
    system("./script/generate rspec ; git add * ; git commit -m 'Setup rspec'")
    system("./script/generate cucumber --#{@opts[:simulator]} --rspec ; git add * ; git commit -m 'Setup cucumber with #{@opts[:simulator]} and rspec options'")
    system("./script/plugin install git://github.com/ezmobius/acl_system2.git ; git add vendor/plugins/acl_system2 ; git commit -m 'Add acl_system2 for role based access control'")

    # Create migrations
    FileUtils.mkdir(@opts[:migrate_dir] = File.join(@opts[:project_dir], "db", "migrate"))
    time = Time.now
    Dir[File.join(@opts[:resource_dir],'migrations','*.rb')].each do |f|
      time += 1
      FileUtils.cp(f,File.join(@opts[:migrate_dir],"#{time.utc.strftime("%Y%m%d%H%M%S")}_" + File.basename(f)))
    end
    system("rake db:migrate ; rake db:test:prepare")

    system("git add * ; git commit -m 'Initial migrations complete'")

    # Create the initializer file
    File.open(File.join(@opts[:project_dir],"config","initializers","baseline.rb"),"w") do |f|
      f.puts "module Baseline"
      f.puts "  AppName = '#{@opts[:project_name]}'"
      f.puts "  DefaultHost = '#{@opts[:project_name].downcase}.com'"
      f.puts '  EmailSender = "#{AppName} <noreply@#{DefaultHost}>"'
      f.puts '  #TODO - Remove when Rails 2.3.6 is released'
      f.puts '  EmailReturnPath = "noreply@#{DefaultHost}"'
      f.puts
      f.puts "  if RAILS_ENV == 'production'"
      f.puts "    ActionMailer::Base.default_url_options[:host] = DefaultHost"
      f.puts "  else"
      f.puts "    ActionMailer::Base.default_url_options[:host] = 'localhost:3000'"
      f.puts "  end"
      f.puts "end"
    end

    # Add stuff to global environment file
    File.open(File.join(@opts[:project_dir],"config","environment.rb"), "r+") do |f|
      lines = f.readlines
      lines.insert(-2, %Q{  config.gem "authlogic"\n})
      f.pos = 0
      f.print lines
      f.truncate(f.pos)
    end

    system("git add * ; git commit -m 'Edit environment files'")

    FileUtils.cp_r("#{@opts[:resource_dir]}/sync/.",@opts[:project_dir])

    system("git add * .autotest ; git commit -m 'Add features, controllers, etc.'")
    system("git rm public/index.html; git commit -m 'And here ...we ...go'")
  end
end
