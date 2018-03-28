# spec/capybara_helper.rb

require 'rails_helper'
require 'capybara/rspec'

Capybara.javascript_driver = :selenium
Capybara.server = :puma
