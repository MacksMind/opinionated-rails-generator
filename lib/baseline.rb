require 'rubygems'
require 'active_support/inflector'
require 'optparse'

class Baseline

  PASSWORD_REGEX = /^(?=.*?[0-9])(?=.*?[A-Z])(?=.*?[a-z])\S+$/

  # constructor
  def initialize
    @script_name = File.basename($0) 
    self.options.parse!(ARGV)

    raise ArgumentError, "ProjectName is required" if ARGV.size != 1

    baseline_dir = File.join(File.dirname(__FILE__),'..')
    @resource_dir = File.expand_path(File.join(baseline_dir,"resources"))
    @project_base ||= File.expand_path(File.join(baseline_dir,".."))
    @project_name = ARGV[0]
    @project_dir = File.join(@project_base,@project_name.underscore)

    raise ArgumentError, "#{@project_dir} already exists." if File.exist?(@project_dir)
  end

  def options #:nodoc:#
    OptionParser.new do |o|
      o.set_summary_indent('  ')
      o.banner =    "Usage: #{@script_name} [options] ProjectName"
      o.define_head "Baseline Rails setup"
      o.separator ""
      o.separator "options"
      o.on("-b","--basedir BASE_DIRECTORY", String, "Specify a project base directory. Defaults to parent of Baseline install dir.") { |basedir| @project_base = basedir }
      #o.on("-v", "--verbose", "Turn on verbose output.") { |$verbose| }
      o.on("-h", "--help", "Show this message.") { puts o; exit }
    end
  end

  def generate_password
    #avoid confusion of 1 vs l, and 0 vs O
    chars = ("a".."k").to_a + ("m".."z").to_a + ("A".."N").to_a + ("P".."Z").to_a + ("2".."9").to_a
    until (pwd = Array.new(16).collect{chars[rand(chars.size)]}.join) =~ PASSWORD_REGEX do ; end
    pwd
  end

  def generate!
    # Setup a default environment
    system("rails #{@project_dir}")
    Dir.chdir(@project_dir)
    FileUtils.cp(File.join(@resource_dir, "gitignore"),File.join(@project_dir,".gitignore"))
    system("git init ; git add .gitignore ; git add * ; git commit -m 'Default rails install'")

    # Edit database settings
    File.open(File.join(@project_dir,"config","database.yml"), "r+") do |f|
      lines = f.readlines
      new = lines[0,lines.index("production:\n") + 1]
      new << "  adapter: mysql\n"
      new << "  encoding: utf8\n"
      new << "  database: #{@project_name.underscore}_production\n"
      new << "  username: #{@project_name.underscore}\n"
      new << "  password: #{generate_password}\n"
      new << "  socket: /var/run/mysqld/mysqld.sock\n"
      f.pos = 0
      f.print new
      f.truncate(f.pos)
    end
    system("git add config/database.yml ; git commit -m 'Production database settings'")

    # Setup RSpec and Cucumber
    system("./script/generate rspec ; git add * ; git commit -m 'Setup rspec'")
    system("./script/generate cucumber --webrat --rspec ; git add * ; git commit -m 'Setup cucumber with webrat and rspec options'")
    system("git submodule add git://github.com/ezmobius/acl_system2.git vendor/plugins/acl_system2 ; git commit -m 'Add acl_system2 for role based access control'")

    # Create migrations
    FileUtils.mkdir(@migrate_dir = File.join(@project_dir, "db", "migrate"))
    time = Time.now
    Dir[File.join(@resource_dir,'migrations','*.rb')].each do |f|
      time += 1
      FileUtils.cp(f,File.join(@migrate_dir,"#{time.utc.strftime("%Y%m%d%H%M%S")}_" + File.basename(f)))
    end
    system("rake db:migrate")

    system("git add * ; git commit -m 'Initial migrations complete'")

    # Create the initializer file
    File.open(File.join(@project_dir,"config","initializers","baseline.rb"),"w") do |f|
      f.puts "module Baseline"
      f.puts "  AppName = '#{@project_name}'"
      f.puts "  DefaultHost = '#{@project_name.downcase}.com'"
      f.puts '  EmailSender = "#{AppName} <noreply@#{DefaultHost}>"'
      f.puts '  #TODO - Remove when Rails 2.3.6 is released'
      f.puts '  EmailReturnPath = "noreply@#{DefaultHost}"'
      f.puts "end"
    end

    # Add a default url to individual environment files
    ["development","test","cucumber","production"].each do |env|
      File.open(File.join(@project_dir,"config","environments","#{env}.rb"),"a") do |f|
        f.print("\n", 'require File.join(File.dirname(__FILE__),"..","initializers","baseline.rb")') if env == 'production'
        f.print("\n", 'config.action_mailer.default_url_options = { :host => "', (env == 'production' ? '#{Baseline::DefaultHost}' : 'localhost:3000'), '" }', "\n")
      end
    end

    # Add stuff to global environment file
    File.open(File.join(@project_dir,"config","environment.rb"), "r+") do |f|
      lines = f.readlines
      lines.insert(-2, %Q{  config.gem "authlogic"\n})
      f.pos = 0
      f.print lines
      f.truncate(f.pos)
    end

    system("git add * ; git commit -m 'Edit environment files'")

    FileUtils.cp_r("#{@resource_dir}/sync/.",@project_dir)

    system("git add * .autotest ; git commit -m 'Add features, controllers, etc.'")
    system("git rm public/index.html; git commit -m 'And here ...we ...go'")
  end
end
