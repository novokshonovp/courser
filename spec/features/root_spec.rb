require 'rails_helper'
require './spec/features/helpers.rb'

feature "Show dollar rate", type: :feature do
  let(:forced) { '100' }

  scenario "visit root page with fetched course", js: true do
    visit root_path
    expect(find('#rate').text.split(':').first).to eq 'USD'
    expect(find('#rate').text.split(':').last).to match /\d/
  end
  scenario "set forced rate", js: true do
    rate = ''
    in_browser(:one) do
      visit root_path
      p rate
      rate = parse_rate
    end

    in_browser(:two) do
      visit admin_path
      fill_in('course_rate', :with => forced)
      fill_in('course_uptodate', :with => Time.now + 3.seconds)
      click_on('Submit')
    end

    byebug
    in_browser(:one) do
      forced_rate = parse_rate
      expect(forced_rate).to eq(forced)
    end
  end
end
