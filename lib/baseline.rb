require 'rubygems'
require 'active_support/inflector'
require 'optparse'
require 'fileutils'

class Baseline

  PASSWORD_REGEX = /^(?=.*?[0-9])(?=.*?[A-Z])(?=.*?[a-z])\S+$/

  def system(cmd, *args)
    puts "==> #{cmd}"
    super
  end

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
      o.banner =    "Usage: ruby #{File.basename($0)} [options] ProjectName"
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
    system("rails new #{@opts[:project_dir]}")
    Dir.chdir(@opts[:project_dir])
    system("git init && git add . && git commit -m 'Default rails install'")

    # Configure Gemfile
    system("cat #{@opts[:resource_dir]}/patch/Gemfile | patch -p1")
    system("bundle install --without production && git add . && git commit -m 'Configure Gemfile'")

    # Configure New Relic
    system("cp `bundle show newrelic_rpm`/newrelic.yml config && git add . && git commit -m 'Configure New Relic'")

    # Install Devise
    system("./script/rails generate devise:install && git add . && git commit -m 'Install devise'")

    # Install RSpec and Cucumber
    system("./script/rails generate rspec:install && git add . && git commit -m 'Install rspec'")
    system("./script/rails generate cucumber:install --#{@opts[:simulator]} --rspec && git checkout Gemfile && git add . && git commit -m 'Install cucumber with #{@opts[:simulator]} and rspec options'")

    # Create the initializer file
    File.open(File.join(@opts[:project_dir],"config","initializers","baseline.rb"),"w") do |f|
      f.puts "module Baseline"
      f.puts "  AppName = '#{@opts[:project_name]}'"
      f.puts "  PrimaryDomain = '#{@opts[:project_name].downcase}.com'"
      f.puts '  DefaultHost = "www.#{PrimaryDomain}"'
      f.puts '  EmailSender = "#{AppName} <noreply@#{PrimaryDomain}>"'
      f.puts
      f.puts "  if defined?(Rails)"
      f.puts "    if Rails.env.production?"
      f.puts "      ActionMailer::Base.default_url_options[:host] = DefaultHost"
      f.puts "      ActionMailer::Base.default_url_options[:protocol] = 'https'"
      f.puts "    else"
      f.puts "      ActionMailer::Base.default_url_options[:host] = 'localhost:3000'"
      f.puts "    end"
      f.puts "  end"
      f.puts "end"
    end

    system("git add . && git commit -m 'Create initializer file'")

    # Patch files
    system("find #{@opts[:resource_dir]}/patch -type f | grep -v Gemfile | xargs cat | patch --forward -p1")
    
    system("git add . && git commit -m 'Apply patches'")

    FileUtils.cp_r("#{@opts[:resource_dir]}/sync/.",@opts[:project_dir])

    system("git add . && git commit -m 'Add features, controllers, etc.'")
    
    # Create migrations
    FileUtils.mkdir(@opts[:migrate_dir] = File.join(@opts[:project_dir], "db", "migrate"))
    time = Time.now
    Dir[File.join(@opts[:resource_dir],'migrations','*.rb')].each do |f|
      time += 1
      FileUtils.cp(f,File.join(@opts[:migrate_dir],"#{time.utc.strftime("%Y%m%d%H%M%S")}_" + File.basename(f)))
    end
    system("rake db:migrate")
    system("git add . && git commit -m 'Initial migrations complete'")

    # Configure Devise for User
    system("./script/rails generate devise User && rake db:migrate && git add . && git commit -m 'Configure devise for User'")

    # Remove static index and erb layout
    system("git rm public/index.html app/views/layouts/application.html.erb && git commit -m 'And here ...we ...go'")

    # Prep for use
    system("rake db:fixtures:load")
    system("rake db:seed")
    system("rake db:test:prepare")
  end
end
