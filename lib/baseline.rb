require 'rubygems'
require 'rails'
require 'optparse'
require 'fileutils'

class Baseline

  def system(cmd, *args)
    puts "==> #{cmd}"
    super
  end

  def rails_version_minor
    Rails.version.sub(/\.[^.]$/,'')
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
    options[:project_dir] = File.join(project_base,options[:project_name].underscore.dasherize)
    options
  end

  def generate!
    # Setup a default environment
    system("rails new #{@opts[:project_dir]}")
    Dir.chdir(@opts[:project_dir])
    system("git add . && git commit -m 'Default rails install'")

    # Configure Gemfile
    system('sed -e "s/^gem \'sqlite3\'$/# gem \'sqlite3\'/" Gemfile > Gemfile.new && mv Gemfile.new Gemfile')
    system("find #{@opts[:resource_dir]}/patch1 -type f | xargs cat | patch --forward -p1")
    system("bundle install --without production && bundle update && git add . && git commit -m 'Apply initial patches'")

    # Install Devise
    system("bundle exec rails generate devise:install && git add . && git commit -m 'Install devise'")

    # Install RSpec and Cucumber
    system("bundle exec rails generate rspec:install && git add . && git commit -m 'Install rspec'")
    system("bundle exec rails generate cucumber:install --#{@opts[:simulator]} --rspec && git checkout Gemfile && git add . && git commit -m 'Install cucumber with #{@opts[:simulator]} and rspec options'")

    # Patch files
    system("find #{@opts[:resource_dir]}/patch2 -type f | xargs cat | patch --forward -p1")
    system("git add . && git commit -m 'Apply main patches'")

    # Sync resources
    FileUtils.rm(File.join(@opts[:project_dir],'app/views/layouts/application.html.erb'))
    FileUtils.cp_r("#{@opts[:resource_dir]}/sync/.",@opts[:project_dir])

    system("git add . && git commit -m 'Add features, controllers, etc.'")

    # Create migrations
    FileUtils.mkdir(@opts[:migrate_dir] = File.join(@opts[:project_dir], "db", "migrate"))
    fake_timestamp = 20171129180001
    Dir[File.join(@opts[:resource_dir],'migrations','*.rb')].each do |f|
      system("sed -e '1s/$/[#{rails_version_minor}]/' #{f} > #{File.join(@opts[:migrate_dir],"#{fake_timestamp}_" + File.basename(f))}")
      fake_timestamp += 1
    end
    system("bundle exec rake db:drop db:create db:migrate")
    system("git add . && git commit -m 'Initial migrations complete'")

    # Configure Devise for User
    system("bundle exec rails generate devise User")
    Dir[File.join(@opts[:migrate_dir],'*_add_devise_to_users.rb')].each do |f|
      FileUtils.mv(f, File.join(@opts[:migrate_dir], "#{fake_timestamp}_add_devise_to_users.rb"))
    end
    system("find #{@opts[:resource_dir]}/patch3 -type f | xargs cat | patch --forward -p1")
    system("bundle exec rake db:migrate && git add . && git commit -m 'Configure devise for User'")

    # Run Rubocop
    system("rubocop --auto-correct && rubocop --auto-gen-config && git add . && git commit -m 'Rubocop changes'")

    # Prep for use
    system('bundle exec rake db:fixtures:load db:seed')

    # Add Heroku remote
    if @opts[:project_name] == 'ShinyObject'
      system('git remote add heroku https://git.heroku.com/shiny-object.git && git fetch heroku && git branch --set-upstream-to heroku/master')
    end
  end
end
