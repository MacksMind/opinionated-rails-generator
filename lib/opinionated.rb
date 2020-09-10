# frozen_string_literal: true

# Copyright 2020 Mack Earnhardt

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'
require 'tempfile'

# Optionated generator
class ::Opinionated
  # Initialize defaults
  def initialize(app_path:)
    raise ::ArgumentError, 'app_path is blank' if app_path.blank?

    @project_dir = ::Pathname.new(app_path).realdirpath
    raise ::ArgumentError, "#{@project_dir} already exists." if ::File.exist?(@project_dir)

    @migrate_dir = ::File.join(@project_dir, 'db', 'migrate')
    @resource_dir = ::File.expand_path('../resources', ::File.dirname(__FILE__))
  end

  # Exec system comment and terminate on non-zero exit
  def syscmd(cmd, ignore_warnings: false)
    puts "==> #{cmd}"
    ::Bundler.with_unbundled_env do
      system(cmd) || ignore_warnings || exit(1)
    end
  end

  # Grab rails major/minor for migrations
  def rails_major_minor
    @rails_major_minor ||=
      ::Bundler.with_unbundled_env do
        `rails --version`.match(/Rails (\d+\.\d+)/)[1].to_s
      end
  end

  # Commit with message
  def commit(msg)
    syscmd('git add .')
    if msg.include?("\n") || msg.include?("'")
      ::Tempfile.open do |f|
        f.write msg
        f.close
        syscmd("git commit -F #{f.path}")
      end
      puts "===> commit message\n#{msg}"
    else
      syscmd("git commit -m '#{msg}'")
    end
  end

  # Generate new rails project
  def generate!
    rails_new
    update_gemfile
    install_devise
    install_rspec
    install_cucumber
    apply_patches
    sync_mvc_and_specs
    create_migrations
    configure_devise
    install_bootstrap
    install_fontawesome
    install_annotate
    eslint_prettier
    rubocop_cleanup
    fixtures_and_seed
    run_tests
  end

  # Exec `rails new`
  def rails_new
    syscmd("rails new #{@project_dir} --database postgresql --skip-spring")
    ::Dir.chdir(@project_dir)

    # Remove credentials right out of the gate, because we don't want them in the example repo
    # Recreate if/when needed using `rails credentials:edit`
    ::FileUtils.rm_f(::File.join(@project_dir, 'config/master.key'))
    ::FileUtils.rm_f(::File.join(@project_dir, 'config/credentials.yml.enc'))

    commit(<<~MSG)
      `rails new` with PostgreSQL and not spring

      spring can make debugging very frustrating and we hates it forever
    MSG
  end

  # Update Gemfile and set config vars
  def update_gemfile
    syscmd("find #{@resource_dir}/patch1 -type f | xargs cat | patch --forward -p1")
    syscmd("bundle config set without 'production'")
    syscmd('bundle install')
    commit('Update Gemfile and set config vars')
  end

  # Install devise autentication
  def install_devise
    syscmd('bundle exec rails generate devise:install')
    syscmd('sed -i "" -E "s/[a-z0-9]{128}/set_using_rails_secret_if_needed/" config/initializers/devise.rb')
    commit('Install devise')
  end

  # Install rspec
  def install_rspec
    syscmd('bundle exec rails generate rspec:install')
    commit('Install rspec')
  end

  # Install cucumber
  def install_cucumber
    syscmd('bundle exec rails generate cucumber:install')
    commit('Install cucumber')
  end

  # Apply main patches
  def apply_patches
    syscmd("find #{@resource_dir}/patch2 -type f | xargs cat | patch --forward -p1")
    commit('Apply main patches')
  end

  # Sync bulk of the opionated app
  def sync_mvc_and_specs
    ::FileUtils.rm(::File.join(@project_dir, 'app/views/layouts/application.html.erb'))
    ::FileUtils.cp_r("#{@resource_dir}/sync/.", @project_dir)
    commit('Add models, controllers, specs, etc.')
  end

  # Create initial migrations
  def create_migrations
    ::FileUtils.mkdir(@migrate_dir)
    ::Dir[::File.join(@resource_dir, 'migrations', '*.rb')].sort.each do |f|
      syscmd(
        "sed -e '1s/$/[#{rails_major_minor}]/' #{f} > " \
        "#{::File.join(@migrate_dir, ::File.basename(f))}"
      )
    end
    syscmd('bundle exec rails db:drop db:create db:migrate')
    commit('Initial migrations')
  end

  # Configure devise
  def configure_devise
    # TODO: THOR_SILENCE_DEPRECATION should come out once https://github.com/heartcombo/devise/pull/5258 is released
    syscmd('THOR_SILENCE_DEPRECATION=1 bundle exec rails generate devise User')
    ::Dir[::File.join(@migrate_dir, '*_add_devise_to_users.rb')].each do |f|
      ::FileUtils.mv(f, ::File.join(@migrate_dir, '20200801180004_add_devise_to_users.rb'))
    end
    commit('Prelim devise configuration')
    syscmd("find #{@resource_dir}/patch3 -type f | xargs cat | patch --forward -p1")
    syscmd('bundle exec rails db:migrate')
    commit('Finish devise configuration')
  end

  # Install bootstrap 5
  def install_bootstrap
    syscmd('yarn add bootstrap@next popper.js')
    commit('Bootstrap 5')
  end

  # Install fontawesome
  def install_fontawesome
    syscmd('yarn add @fortawesome/fontawesome-svg-core @fortawesome/free-solid-svg-icons')
    commit('Font Awesome')
  end

  # Install and exec annotate
  def install_annotate
    syscmd('bundle exec rails generate annotate:install')
    syscmd('bundle exec annotate')
    commit('Annotate models')
  end

  # Install eslint and prettier
  def eslint_prettier
    syscmd('yarn add -D eslint prettier eslint-plugin-prettier eslint-config-prettier eslint-config-airbnb ' \
           'eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-import')
    commit('Eslint / Prettier')
  end

  # Rubocop cleanup
  def rubocop_cleanup
    syscmd('bundle exec rubocop --auto-correct', ignore_warnings: true)
    syscmd('bundle exec rubocop --auto-gen-config')
    commit('Rubocop cleanup')
  end

  # Load fixtures and db:seed
  def fixtures_and_seed
    syscmd('bundle exec rails db:fixtures:load db:seed')
  end

  # Exec rspec and cucumber tests
  def run_tests
    syscmd('bundle exec rails spec cucumber')
  end
end
