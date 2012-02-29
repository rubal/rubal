require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get create_user" do
    get :create_user
    assert_response :success
  end

end
