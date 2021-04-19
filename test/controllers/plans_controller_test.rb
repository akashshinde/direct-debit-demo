require "test_helper"

class PlansControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get plans_create_url
    assert_response :success
  end

  test "should get list" do
    get plans_list_url
    assert_response :success
  end
end
