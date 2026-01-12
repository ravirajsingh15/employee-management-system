require "test_helper"

class DailyActivitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get daily_activities_index_url
    assert_response :success
  end

  test "should get new" do
    get daily_activities_new_url
    assert_response :success
  end

  test "should get create" do
    get daily_activities_create_url
    assert_response :success
  end
end
