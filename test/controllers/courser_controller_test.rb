require 'test_helper'

class CourserControllerTest < ActionDispatch::IntegrationTest
  test "should get course" do
    get courser_course_url
    assert_response :success
  end

  test "should get admin" do
    get courser_admin_url
    assert_response :success
  end

end
