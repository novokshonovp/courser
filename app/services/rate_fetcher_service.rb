require 'nokogiri'
require 'open-uri'

class RateFetcher
  def initialize(currency_sign)
    @currency_sign = currency_sign
  end

  def fetch
    #TODO Fetch data from cbr.ru
  end

  def self.fetch(*args)
    new(*args).fetch
  end
end
