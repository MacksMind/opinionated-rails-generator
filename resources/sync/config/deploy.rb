require File.join(File.dirname(__FILE__),"initializers","baseline.rb")

set :application, Baseline::AppName.downcase
set :repository,  "set your repository location here"

set :scm, :git
set :git_enable_submodules, 1
set :deploy_via, :remote_cache

set :user, application
set :use_sudo, false
set :deploy_to, "/home/#{application}"

role :web, Baseline::DefaultHost
role :app, Baseline::DefaultHost
role :db, Baseline::DefaultHost, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end