require 'test_helper'

class FoobarsControllerTest < ActionController::TestCase
  setup do
    @foobar = foobars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:foobars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create foobar" do
    assert_difference('Foobar.count') do
      post :create, foobar: @foobar.attributes
    end

    assert_redirected_to foobar_path(assigns(:foobar))
  end

  test "should show foobar" do
    get :show, id: @foobar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @foobar
    assert_response :success
  end

  test "should update foobar" do
    put :update, id: @foobar, foobar: @foobar.attributes
    assert_redirected_to foobar_path(assigns(:foobar))
  end

  test "should destroy foobar" do
    assert_difference('Foobar.count', -1) do
      delete :destroy, id: @foobar
    end

    assert_redirected_to foobars_path
  end
end
