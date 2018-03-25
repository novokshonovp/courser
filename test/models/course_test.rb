require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    @course = Course.new(currency_sign: "USD", rate: 1.001, uptodate: (Time.now + (60 * 60)) )
  end

  test "should be valid" do
    assert @course.valid?
  end

  test "currency sign should be present" do
      @course.currency_sign = ""
      assert_not @course.valid?
  end

  test "rate should be present" do
      @course.rate = ""
      assert_not @course.valid?
  end

  test "rate should be less 100000" do
      @course.rate = 100000
      assert_not @course.valid?
  end

  test "rate should be more 0" do
      @course.rate = 0
      assert_not @course.valid?
  end

  test "date and time should be present" do
    @course.uptodate = ""
    assert_not @course.valid?
  end
 test 'currency sign should be USD' do
   @course.currency_sign = 'US1'
   assert_not @course.valid?
 end

 test 'date and time should head forward' do
   @course.uptodate = Time.now - 1
   assert_not @course.valid?
 end
end
