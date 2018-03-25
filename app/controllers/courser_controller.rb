class CourserController < ApplicationController
  DATES_FORMAT= '%Y-%m-%d %H:%M %p'

  def course
    gon.currency = 'USD'
    gon.rate = CourserController.rate
  end

  def admin
    @course = Course.new
    @courses = course_history
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      broadcast(@course)
      redirect_to courser_admin_url
    else
      @courses = course_history
      render 'admin'
    end
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

  def course_params
    params.require(:course).permit(:currency_sign, :rate, :uptodate)
  end
end
