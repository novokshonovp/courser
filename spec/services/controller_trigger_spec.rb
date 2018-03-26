require 'simplecov'
SimpleCov.start
require './config/environment'
require 'webmock/rspec'
require './app/services/controller_trigger'


describe ControllerTrigger do
  describe '#trigger' do
    subject { ControllerTrigger.trigger( currency_sign: currency_sign,
                                         rate: example_rate ) }
    let(:currency_sign) { 'USD' }
    let(:example_rate) { '55.01' }
    let(:host) {  Rails.application.config.default_url_options[:host] }

    context 'when success trigger' do
      before do
        stub_request(:post, /#{host}/)
            .to_return(status: 200, body: response )
      end
      let(:response) { '{"response":"OK"}' }
      it { is_expected.to be true }
    end

    context 'when failed trigger' do
      before do
        stub_request(:post, /#{host}/)
            .to_return(status: 404, body: nil )
      end
      it { expect { subject }.to raise_error /code: 404/ }
    end

  end
end
