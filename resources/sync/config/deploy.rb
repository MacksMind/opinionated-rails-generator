require "bundler/capistrano"

set :application, Rails.application.config.app_name.underscore
set :repository,  "set your repository location here"

set :scm, :git
set :git_enable_submodules, 1
set :deploy_via, :remote_cache

set :user, application
set :use_sudo, false
set :deploy_to, "/home/#{application}"

set :bundle_dir,      ""
set :bundle_flags,    "--quiet"

server Rails.application.confing.canonical_hostname, :app, :web, :db, primary: true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
