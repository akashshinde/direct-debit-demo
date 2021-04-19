require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get payments_create_url
    assert_response :success
  end

  test "should get list" do
    get payments_list_url
    assert_response :success
  end
end
