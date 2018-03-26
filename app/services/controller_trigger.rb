require 'open-uri'
require 'net/http'

class ControllerTrigger
  include Rails.application.routes.url_helpers

  SUCCESS = '200'.freeze

  def initialize(args)
    @currency_sign = args[:currency_sign]
    @rate = args[:rate]
  end

  def trigger
    response = Net::HTTP.post_form(URI.parse(app_url),
                                   currency_sign: @currency_sign,
                                   rate: @rate)
    unless success_response?(response.code)
      raise "Error refresh app by #{url},"\
            " code: #{response.code}, #{response.message}"
    end
    true
  end

  def self.trigger(*args)
    new(*args).trigger
  end

  private
  
  def success_response?(response)
    response == SUCCESS
  end

  def app_url
    Rails.application.routes
         .default_url_options[:host] = Rails.application
                                            .config.default_url_options[:host]
    refresh_rate_url
  end
end
