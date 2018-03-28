require 'simplecov'
SimpleCov.start
require 'rails_helper'
require './spec/features/helpers.rb'

feature "show admin page", type: :feature do
  let(:forced) { '10.0' }
  scenario "admin page remembers", js: true do
    visit admin_path
    expect(page.has_content?('9.99')).to be true
    fill_admin_form(forced, 3)
    expect(page.has_content?(forced)).to be true
  end
end
