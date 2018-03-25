require 'simplecov'
SimpleCov.start
require 'webmock/rspec'
require './app/services/rate_fetcher_service'
describe RateFetcherService do

  before do
    stub_request(:get, /#{RateFetcherService::SITE_URL}/)
        .to_return(status: 200, body: response )
  end
  let(:response) { File.open('./spec/fixtures/cbr_rate.html') }

  describe '#fetch' do
    subject { RateFetcherService.fetch(currency_sign) }
    context 'when have currency data' do
      let(:currency_sign) { 'USD' }
      it { is_expected.to eq("57.1072") }
    end
    context 'when no currency data' do
      let(:currency_sign) { 'NON EXIST' }
      it { is_expected.to be_nil }
    end
  end
end
