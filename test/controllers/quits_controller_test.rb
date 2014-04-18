require 'test_helper'

class QuitsControllerTest < ActionController::TestCase
  setup do
    @quit = quits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quit" do
    assert_difference('Quit.count') do
      post :create, quit: { investment: @quit.investment, length: @quit.length, start_date: @quit.start_date, substance: @quit.substance, user_id: @quit.user_id }
    end

    assert_redirected_to quit_path(assigns(:quit))
  end

  test "should show quit" do
    get :show, id: @quit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quit
    assert_response :success
  end

  test "should update quit" do
    patch :update, id: @quit, quit: { investment: @quit.investment, length: @quit.length, start_date: @quit.start_date, substance: @quit.substance, user_id: @quit.user_id }
    assert_redirected_to quit_path(assigns(:quit))
  end

  test "should destroy quit" do
    assert_difference('Quit.count', -1) do
      delete :destroy, id: @quit
    end

    assert_redirected_to quits_path
  end
end
