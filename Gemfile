# frozen_string_literal: true
ruby '2.3.1'

source 'https://rubygems.org' do
  gem 'coffee-rails', '~> 4.1.0'
  gem 'config'
  gem 'devise'
  gem 'jbuilder', '~> 2.0'
  gem 'jquery-rails'
  gem 'mysql2', '>= 0.3.18', '< 0.5'
  gem 'omniauth'
  gem 'omniauth-google-oauth2'
  gem 'puma', '~> 3.0'
  gem 'rails', '>= 5.0.0.rc1', '< 5.1'
  gem 'sass-rails', '~> 5.0'
  gem 'slim-rails'
  gem 'turbolinks', '~> 5.x'
  gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
  gem 'uglifier', '>= 1.3.0'
  gem 'virtus'

  group :development do
    gem 'binding_of_caller'
    gem 'annotate'
    gem 'better_errors'
    gem 'bullet', group: :test
    gem 'byebug', platform: :mri, group: :test
    gem 'listen', '~> 3.0.5'
    gem 'pry-byebug', group: :test
    gem 'pry-rails', group: :test
    gem 'rubocop', require: false
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
    gem 'web-console'
  end

  group :test do
    gem 'capybara'
    gem 'capybara-screenshot'
    gem 'database_rewinder'
    gem 'factory_girl_rails', group: :development
    gem 'ffaker',             group: :development
    gem 'json_expressions'
    gem 'launchy'
    gem 'poltergeist'
    gem 'rails-controller-testing'
    gem 'rspec-rails'
    gem 'rspec_junit_formatter'
    gem 'simplecov', require: false
  end

  group :doc do
    gem 'yard'
  end
end
