require "test_helper"

class CustomerDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get customer_details_view_url
    assert_response :success
  end
end
