
class RateSync

  def initialize(database, namespace = 'rate', currency_sign)
    @database = database
    @namespace = namespace
    @currency_sign = currency_sign
  end

  def force(rate, expire_datetime)
    @database.multi do |multi|
      multi.set(forced, { currency_sign: @currency_sign,
                                rate: rate }.to_json)
      multi.expire(forced, Integer(expire_datetime.utc - Time.now.utc))
    end
  end

  def pull_rate
    forced_rate || fetched_rate
  end

  def push_rate(rate)
    if fetched_rate != rate
      @database.set("#{@namespace}:#{@currency_sign}", rate)
      true
    else
      false
    end
  end
  
  def forced_rate?
    @database.get(forced).nil? ? false : true
  end

  private
  def forced
    "#{@namespace}:forced"
  end

  def fetched_rate
    @database.get("#{@namespace}:#{@currency_sign}")
  end

  def forced_rate
    rate = @database.get(forced)
    rate.nil? ? nil : JSON.parse(rate)['rate']
  end

end
