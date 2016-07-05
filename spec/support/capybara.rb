# frozen_string_literal: true
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 8 # default 2
# Capybara.default_selector = :xpath

RSpec.configure do |config|
  config.include Capybara::DSL, type: :feature

  config.before type: :feature, js: true do
    page.driver.resize_window(1680, 1050)
  end
end
