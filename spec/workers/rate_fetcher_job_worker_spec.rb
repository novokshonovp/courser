require 'simplecov'
SimpleCov.start
require 'rails_helper'
require 'sidekiq/testing'
require 'webmock/rspec'


RSpec.describe RateFetcherJobWorker, type: :worker do

  describe 'Job pushed on to the queue' do
  it { expect { RateFetcherJobWorker.perform_async('USD') }
            .to change(RateFetcherJobWorker.jobs, :size).by(1) }
  end
  let(:work) { RateFetcherJobWorker.new }
  describe 'perform' do
    subject { work.perform('USD') }
    context 'when no access to fetching site' do
      before do
        stub_request(:get, /#{RateFetcherService::SITE_URL}/)
            .to_return(status: 404, body: nil )
      end
      it { expect { subject}.to raise_error /404/ }
    end

  end
end
