require "test_helper"

class HealthTest < ActionDispatch::IntegrationTest
  test "health endpoint succeeds when the application boots" do
    get "/up"

    assert_response :success
  end
end
