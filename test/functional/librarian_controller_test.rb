require 'test_helper'

class LibrarianControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get check_out" do
    get :check_out
    assert_response :success
  end

  test "should get check_in" do
    get :check_in
    assert_response :success
  end

  test "should get list_onloan" do
    get :list_onloan
    assert_response :success
  end

end
