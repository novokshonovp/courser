class CourseChannel < ApplicationCable::Channel
  CHANNEL_NAME = 'CourseChannel'.freeze

  def subscribed
    stream_from CHANNEL_NAME
  end

  def send_message(data)
    ActionCable.server.broadcast CHANNEL_NAME,
                                 currency_sign: data.currency_sign,
                                 rate: data.rate
  end
end
