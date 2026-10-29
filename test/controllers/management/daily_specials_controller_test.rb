require "test_helper"

class Management::DailySpecialsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get management_daily_specials_index_url
    assert_response :success
  end
end
