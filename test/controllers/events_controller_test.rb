require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get events_list_url
    assert_response :success
  end
end
