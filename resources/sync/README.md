OpinionatedRails
================

Rails 6 application with these choices:

* [PostgreSQL](https://www.postgresql.org/) database
* [Bootstrap V5](https://v5.getbootstrap.com/) front-end toolkit
* [Devise](https://github.com/heartcombo/devise) authentication
* [Pundit](https://github.com/varvet/pundit) authorization
* [Slim](http://slim-lang.com/) templating engine
* [RSpec](https://rspec.info/) & [Cucumber](https://cucumber.io/) testing
* [Bullet](https://github.com/flyerhzm/bullet) N+1 detection
* [FactoryBot](https://github.com/thoughtbot/factory_bot) test data
* [Kaminari](https://github.com/kaminari/kaminari) pagination
* [Ransack](https://github.com/activerecord-hackery/ransack) search
* [MetaTags](https://github.com/kpumuk/meta-tags) SEO
* [Pry](http://pry.github.io/) console
* [Gravatar](https://en.gravatar.com/) with fallback to [LetterAvatar](https://github.com/ksz2k/letter_avatar)
* [RuboCop](https://rubocop.org/) & [ESLint](https://eslint.org/) linters, with [Prettier](https://prettier.io/) formatting
* Model [annotation](https://github.com/ctran/annotate_models)
* Code [coverage](https://github.com/colszowka/simplecov)
* Ready for cloud deploy at [Heroku](https://www.heroku.com/)

# Background

I used to have a Rails project whose sole purpose was to provide a jumping off point for other Rails projects. Regenerating pieces of it every time one of its dependencies changed was tedious, so I scripted building a new app and dropping in the pieces that don't come from generators.

# Contributing

See [OpinionatedRailsGenerator](https://github.com/MacksMind/opinionated-rails-generator)

# Usage

## Heroku Deploy

* Update `db/seeds.rb` with *your* preferred info and `git commit` the change
* Install [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) if you haven't already
* `heroku create [APP]`
* `heroku addons:create sendgrid:starter`
* `heroku labs:enable runtime-dyno-metadata`
* `git push heroku master`
* `heroku rake db:fixtures:load db:seed`
* `heroku open`
