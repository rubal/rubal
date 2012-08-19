require 'test_helper'

class NewsTrendsControllerTest < ActionController::TestCase
  setup do
    @news_trend = news_trends(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:news_trends)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create news_trend" do
    assert_difference('NewsTrend.count') do
      post :create, news_trend: { name: @news_trend.name }
    end

    assert_redirected_to news_trend_path(assigns(:news_trend))
  end

  test "should show news_trend" do
    get :show, id: @news_trend
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @news_trend
    assert_response :success
  end

  test "should update news_trend" do
    put :update, id: @news_trend, news_trend: { name: @news_trend.name }
    assert_redirected_to news_trend_path(assigns(:news_trend))
  end

  test "should destroy news_trend" do
    assert_difference('NewsTrend.count', -1) do
      delete :destroy, id: @news_trend
    end

    assert_redirected_to news_trends_path
  end
end
