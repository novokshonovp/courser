require 'simplecov'
SimpleCov.start
require 'redis'
require './app/services/rate_sync'


describe RateSync do
  after do
    redis = Redis.new
    redis.del('test:USD')
    redis.del('test:forced')
  end
  let(:rs) { RateSync.new(Redis.new, namespace='test', 'USD') }
  describe '#push_rate' do
    subject { rs.push_rate('55') }

    context 'when new rate' do
      it { is_expected.to be true }
    end

    context 'when rate already exist' do
      before { rs.push_rate('55') }
      it { is_expected.to be false }
    end
  end

  describe '#pull_rate' do
    subject { rs.pull_rate }
    context 'when forced' do
      before do
        rs.push_rate('55')
        rs.force('100', Time.now + 100)
      end
      it { is_expected.to eq('100') }
    end
    context 'when fetcher' do
      before do
        rs.push_rate('55')
      end
      it { is_expected.to eq('55') }
    end
  end

  describe '#forced_rate?' do
    subject { rs.forced_rate? }

    context 'when forced' do
      before do
        rs.push_rate('55')
        rs.force('100', Time.now + 10)
      end
      it { is_expected.to be true }
    end
    context 'when fetcher' do
      before do
        rs.push_rate('55')
      end
      it { is_expected.to be false }
    end
  end
end
