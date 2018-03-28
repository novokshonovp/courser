require 'simplecov'
SimpleCov.start
require 'rails_helper'
require './spec/features/helpers.rb'
require 'webmock/rspec'
WebMock.allow_net_connect!
Capybara.server = :puma, { Silent: true }
Capybara.server_port = 4000

feature "Show dollar rate", type: :feature do
  before do
    stub_request(:get, /#{RateFetcherService::SITE_URL}/)
        .to_return(status: 200, body: response )
    rs.push_rate(initial_rate)
  end
  let(:rs) { RateSync.new($redis, 'USD') }
  let(:response) { File.open('./spec/fixtures/cbr_rate.html') }
  let(:initial_rate) { '10.0' }
  let(:new_fetched_rate) { '50.0001' }
  let(:forced) { '100.0' }

  scenario "visit root page with fetched course", js: true do
    visit root_path
    expect(find('#rate').text.split(':').first).to eq('USD')
    expect(find('#rate').text.split(':').last.strip).to eq(initial_rate)
  end

  scenario "set forced rate", js: true do
    rate = ''
    in_browser(:one) do
      visit root_path
      rate = parse_rate
    end

    in_browser(:two) do
      visit admin_path
      fill_in('course_rate', :with => forced)
      fill_in('course_uptodate', :with => Time.now + 5.seconds)
      click_on('Submit')
    end

    in_browser(:one) do
      forced_rate = parse_rate.strip
      expect(forced_rate).to eq(forced)
    end

    5.downto(0) do |tick|
      p "Lag tick to expire <forced-rate> countdown: #{tick}"
      sleep(1)
    end
    in_browser(:one) do
      expect(parse_rate.strip).to eq(rate.strip)
    end

  end

  scenario "change root page rate with changes of fetched rate", js: true do
    visit root_path
    expect(parse_rate.strip).to eq(initial_rate)
    RateFetcherJobWorker.new.perform('USD')
    3.downto(0) do |tick|
      p "Lag tick to finish sidekiq job countdown: #{tick}"
      sleep(1)
    end
    expect(parse_rate.strip).to eq(new_fetched_rate)
  end
end
