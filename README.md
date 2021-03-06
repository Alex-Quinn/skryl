Dorian
======

A personal identity manager and aggregator written in Rails 3.1. A running demo is available at [skryl.org](http://skryl.org).

Currently implemented modules for data aggregation:

* Blog via Atom feed
* GitHub via RSS feed
* GoodReads via XML API
* Twitter via RSS feed
* Nike+ via REST API
* MapMyFitness via REST API

Installation
------------

1. Clone this repository.

    git clone https://github.com/skryl/skryl.git

2. From the new directory, bundle the project's dependencies with `bundle install --path .`.

3. Raise the database schema with `rake db:schema:load` (and remember to specify `RAILS_ENV` for the environment you want to deploy to).

3. Generate a new secret token initialier with `rake secret_deploy`.

4. Customize `config/initializers/app.rb` and set your credentials in `.env.yaml`

5. Customize the views in `app/views` with your own information.

6. Update from all configured modules (e.g. Goodreads, Twitter, etc.) with `rake update` (again, specify `RAILS_ENV`).

7. Start WebBrick with `rails s` (with a `RAILS_ENV`) and go to [localhost:3000](http://localhost:3000), or deploy on a production Rails server like [Phusion Passenger](http://www.modrails.com/) or [Thin](http://code.macournoyer.com/thin/).

### Production

Production is set to use Dalli. Install Memcache via a package manager, or on Heroku:

    heroku addons:add memcache

### Cron

Dorian uses [Whenever](https://github.com/javan/whenever) for Cron configuration. Install the whenever Gem on your system, then use it from the project directory to produce the lines that should go in your Crontab:

    gem install whenever
    whenever

