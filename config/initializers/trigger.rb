require 'concurrent'

def trigger(currency_sign)
  rate = RateSync.new(Redis.new, currency_sign).pull_rate
  ControllerTrigger.trigger(currency_sign: currency_sign,
                            rate: rate)
end

Thread.new do
  redis = Redis.new
  redis.config(:set, 'notify-keyspace-events', 'xE')
  redis.psubscribe('__keyevent@0__:expired') do |on|
    on.pmessage do |_pattern, _channel, message|
      trigger('USD') if message == 'rate:forced'
    end
  end
end
