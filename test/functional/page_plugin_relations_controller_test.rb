require 'test_helper'

class PagePluginRelationsControllerTest < ActionController::TestCase
  setup do
    @page_plugin_relation = page_plugin_relations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_plugin_relations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_plugin_relation" do
    assert_difference('PagePluginRelation.count') do
      post :create, page_plugin_relation: @page_plugin_relation.attributes
    end

    assert_redirected_to page_plugin_relation_path(assigns(:page_plugin_relation))
  end

  test "should show page_plugin_relation" do
    get :show, id: @page_plugin_relation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page_plugin_relation
    assert_response :success
  end

  test "should update page_plugin_relation" do
    put :update, id: @page_plugin_relation, page_plugin_relation: @page_plugin_relation.attributes
    assert_redirected_to page_plugin_relation_path(assigns(:page_plugin_relation))
  end

  test "should destroy page_plugin_relation" do
    assert_difference('PagePluginRelation.count', -1) do
      delete :destroy, id: @page_plugin_relation
    end

    assert_redirected_to page_plugin_relations_path
  end
end
