require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "experience page returns success" do
    get experience_url
    assert_response :success
  end
end
