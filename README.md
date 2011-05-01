Baseline
========

Tool to generate a Rails application with these features:

* Starts with `rails new <project>` for the latest Rails magic
* Configures the production database for MySQL with a generated password
* RSpec2
* Cucumber with Capybara or Webrat (default is Capybara)
* Authentication with Clearance
* Role base access control with CanCan
* Capistrano configured for git-based deploy to a Phusion Passenger based server
* Self-serve account creation with email based account confirmation and password resets
* 100% code coverage
* Stores all this goodness in a git repository with separate commits so you can see what each step did

# Usage

## Generation

    Usage: ruby generate.rb [options] ProjectName
    Baseline Rails setup

    options
      -b, --basedir BASE_DIRECTORY     Specify a project base directory. Defaults to parent of Baseline install dir.
          --webrat                     Use webrat instead of capybara
      -h, --help                       Show this message.

## Testing

Change to your new project directly and test using `AUTOFEATURE=true autospec` (my preference) or `rake spec` and `rake cucumber`.

## Deployment

Typical setup steps using GitHub:

* You MUST edit the :repository setting in config/deploy.rb
* On the server, configure the virtual host. Where the config lives is somewhat distro dependent, but see my sample vhost file below.
* On the server, create a database and login matching the production database settings.
* On the server, create an unprivileged user to execute the application. Typically `adduser <project_owner>`
* Do what you must so you can `ssh project_owner@server` from your development box.
* From your development box, `cap deploy:setup` to create the deploy directories.
* Fix this gotcha: As root on the server, `chmod g-w /home/project_owner` because `cap deploy:setup` changes the permissions in a way that angers ssh.
* As project owner, `ssh git@github.com`. This will fail, but we do it it to update ~/.ssh/known_hosts or Capistrano will fail.
* As project owner, `ssh-keygen`
* Use ~/.ssh/id_rsa.pub as your GitHub deploy key.
* From your development box, `cap deploy:cold`
* Done!!

Here is my typical vhost file:

    <VirtualHost *:80>
      ServerName project.example.com
      DocumentRoot /home/project/current/public
      <Directory /home/project/current/public>
        AllowOverride all
        Options -MultiViews
      </Directory>

      RewriteEngine On

      # Check for maintenance file and redirect all requests
      RewriteCond %{DOCUMENT_ROOT}/system/maintenance.html -f
      RewriteCond %{SCRIPT_FILENAME} !maintenance.html
      RewriteRule ^.*$ /system/maintenance.html [L]

      CustomLog /home/project/shared/log/access.log combined
      ErrorLog /home/project/shared/log/error.log
    </VirtualHost>

# Notes

I used to have a Rails project whose sole purpose was to provide a jumping off point for other Rails projects. I got tired regenerating pieces of it every time one of its dependencies changed. Baseline is my solution. Now I update it for addtional features or because I learned a better way to do something, but there's no need to pull in new files with every upstream version change unless something breaks.

Enjoy!
