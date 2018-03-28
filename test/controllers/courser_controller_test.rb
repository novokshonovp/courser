require 'test_helper'

class CourserControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_url
    assert_response :success
  end

  test "should get admin" do
    get admin_url
    assert_response :success
  end

end
