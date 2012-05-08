require 'test_helper'

class ThepagesControllerTest < ActionController::TestCase
  setup do
    @thepage = thepages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:thepages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thepage" do
    assert_difference('Thepage.count') do
      post :create, thepage: @thepage.attributes
    end

    assert_redirected_to thepage_path(assigns(:thepage))
  end

  test "should show thepage" do
    get :show, id: @thepage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @thepage
    assert_response :success
  end

  test "should update thepage" do
    put :update, id: @thepage, thepage: @thepage.attributes
    assert_redirected_to thepage_path(assigns(:thepage))
  end

  test "should destroy thepage" do
    assert_difference('Thepage.count', -1) do
      delete :destroy, id: @thepage
    end

    assert_redirected_to thepages_path
  end
end
