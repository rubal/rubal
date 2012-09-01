require 'test_helper'

class UserGroupsControllerTest < ActionController::TestCase
  setup do
    @user_group = user_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_group" do
    assert_difference('UserGroup.count') do
      post :create, user_group: { key: @user_group.key, name: @user_group.name, params: @user_group.params }
    end

    assert_redirected_to user_group_path(assigns(:user_group))
  end

  test "should show user_group" do
    get :show, id: @user_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_group
    assert_response :success
  end

  test "should update user_group" do
    put :update, id: @user_group, user_group: { key: @user_group.key, name: @user_group.name, params: @user_group.params }
    assert_redirected_to user_group_path(assigns(:user_group))
  end

  test "should destroy user_group" do
    assert_difference('UserGroup.count', -1) do
      delete :destroy, id: @user_group
    end

    assert_redirected_to user_groups_path
  end
end
