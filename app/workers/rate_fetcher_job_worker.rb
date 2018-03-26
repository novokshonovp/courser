class RateFetcherJobWorker
  include Sidekiq::Worker

  def perform(currency_sign)
    rate = RateFetcherService.fetch(currency_sign)
    raise 'Error fetch rate #{currency_sign}.' if rate.nil?
    rs = RateSync.new(Redis.new, currency_sign)
    return unless rs.push_rate(rate)
    ControllerTrigger.trigger(currency_sign: currency_sign,
                              rate: rate) unless rs.forced_rate?
  end
end
