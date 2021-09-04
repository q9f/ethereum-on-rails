require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get sessions_landing_url
    assert_response :success
  end

  test "should get new" do
    get sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get sessions_create_url
    assert_response :success
  end

  test "should get login" do
    get sessions_login_url
    assert_response :success
  end

  test "should get destroy" do
    get sessions_destroy_url
    assert_response :success
  end
end
