require 'test_helper'

class CmsAdminControllerTest < ActionController::TestCase
  test "should get browse_users" do
    get :browse_users
    assert_response :success
  end

end
