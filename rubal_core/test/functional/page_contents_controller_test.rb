require 'test_helper'

class PageContentsControllerTest < ActionController::TestCase
  setup do
    @page_content = page_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_content" do
    assert_difference('PageContent.count') do
      post :create, page_content: { content: @page_content.content, name: @page_content.name, page_id: @page_content.page_id }
    end

    assert_redirected_to page_content_path(assigns(:page_content))
  end

  test "should show page_content" do
    get :show, id: @page_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page_content
    assert_response :success
  end

  test "should update page_content" do
    put :update, id: @page_content, page_content: { content: @page_content.content, name: @page_content.name, page_id: @page_content.page_id }
    assert_redirected_to page_content_path(assigns(:page_content))
  end

  test "should destroy page_content" do
    assert_difference('PageContent.count', -1) do
      delete :destroy, id: @page_content
    end

    assert_redirected_to page_contents_path
  end
end
