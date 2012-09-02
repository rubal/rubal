require 'test_helper'

class CatalogSectionsControllerTest < ActionController::TestCase
  setup do
    @catalog_section = catalog_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalog_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalog_section" do
    assert_difference('CatalogSection.count') do
      post :create, catalog_section: { description: @catalog_section.description, name: @catalog_section.name }
    end

    assert_redirected_to catalog_section_path(assigns(:catalog_section))
  end

  test "should show catalog_section" do
    get :show, id: @catalog_section
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catalog_section
    assert_response :success
  end

  test "should update catalog_section" do
    put :update, id: @catalog_section, catalog_section: { description: @catalog_section.description, name: @catalog_section.name }
    assert_redirected_to catalog_section_path(assigns(:catalog_section))
  end

  test "should destroy catalog_section" do
    assert_difference('CatalogSection.count', -1) do
      delete :destroy, id: @catalog_section
    end

    assert_redirected_to catalog_sections_path
  end
end
