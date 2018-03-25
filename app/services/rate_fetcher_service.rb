require 'nokogiri'
require 'open-uri'

class RateFetcherService
  SITE_URL = 'http://www.cbr.ru'.freeze
  DATA_URL = '/currency_base/daily.aspx?date_req=01.01.2500'.freeze

  def initialize(currency_sign)
    @currency_sign = currency_sign
  end

  def fetch
    doc = Nokogiri::HTML(open(SITE_URL + DATA_URL))
    rows = doc.css('table.data').css('tbody').css('tr').drop(1)
    row = rows.select { |data| data.css('td')[1].text == @currency_sign }
              .first
    row.nil? ? nil : parse_rate_field(row.css('td').last.text)
  end

  def self.fetch(*args)
    new(*args).fetch
  end

  private

  def parse_rate_field(text)
    text.strip.gsub(/,/,'.')
  end
end
