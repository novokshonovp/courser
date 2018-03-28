require 'simplecov'
SimpleCov.start
require 'rails_helper'

describe Course do
  it "has a valid factory" do
    expect(FactoryBot.create(:course)).to be_valid
  end

  it 'is invalid without a currency_sign' do
    expect(FactoryBot.build(:course, currency_sign: nil).save).to be false
  end

  it 'should be USD' do
    expect(FactoryBot.build(:course, currency_sign: 'JPY').save).to be false
  end

  it 'is invalid without a rate' do
    expect(FactoryBot.build(:course, rate: nil).save).to be false
  end

  it 'rate not more 100_000' do
    expect(FactoryBot.build(:course, rate: 100_000).save).to be false
  end

  it 'rate not less 0.0001' do
    expect(FactoryBot.build(:course, rate: 0).save).to be false
  end

  it 'datetime should head forward' do
    expect(FactoryBot.build(:course, uptodate: Time.now - 1).save).to be false
  end

end
