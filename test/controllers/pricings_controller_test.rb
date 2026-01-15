require "test_helper"

class PricingsControllerTest < ActionDispatch::IntegrationTest
  test "should get pricing" do
    get pricings_pricing_url
    assert_response :success
  end
end
