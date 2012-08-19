require 'test_helper'

class SnippetsControllerTest < ActionController::TestCase
  setup do
    @snippet = snippets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:snippets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create snippet" do
    assert_difference('Snippet.count') do
      post :create, snippet: { description: @snippet.description, name: @snippet.name, path: @snippet.path, subst_name: @snippet.subst_name }
    end

    assert_redirected_to snippet_path(assigns(:snippet))
  end

  test "should show snippet" do
    get :show, id: @snippet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @snippet
    assert_response :success
  end

  test "should update snippet" do
    put :update, id: @snippet, snippet: { description: @snippet.description, name: @snippet.name, path: @snippet.path, subst_name: @snippet.subst_name }
    assert_redirected_to snippet_path(assigns(:snippet))
  end

  test "should destroy snippet" do
    assert_difference('Snippet.count', -1) do
      delete :destroy, id: @snippet
    end

    assert_redirected_to snippets_path
  end
end
