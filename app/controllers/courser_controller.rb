class CourserController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:course, :admin, :create]

  DATES_FORMAT = '%Y-%m-%d %H:%M %p %z'.freeze

  def course
    gon.currency = 'USD'
    gon.rate = ratesync.pull_rate
  end

  def admin
    @course = Course.new
    @courses = course_history
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      ratesync.force(@course.rate, @course.uptodate)
      broadcast(@course)
      redirect_to courser_admin_url
    else
      @courses = course_history
      render 'admin'
    end
  end

  def refresh_rate
    @course = Course.new(currency_sign: params[:currency_sign],
                          rate: params[:rate])
    broadcast(@course)
    render status: 200, json: { response: "OK" }
  end

  def self.rate
    @rate ||= 'Service Unavailable!'
  end

  private

  def course_history
    Course.all.order(created_at: :desc)
  end

  def broadcast(course)
    ActionCable.server.broadcast CourseChannel::CHANNEL_NAME,
                                 currency_sign: course.currency_sign,
                                 rate: course.rate
  end

  def ratesync
    RateSync.new($redis, 'USD')
  end

  def course_params
    params.require(:course).permit(:currency_sign, :rate, :uptodate)
  end
end
