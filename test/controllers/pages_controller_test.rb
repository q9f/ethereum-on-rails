require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get demo" do
    get pages_demo_url
    assert_response :success
  end
end
