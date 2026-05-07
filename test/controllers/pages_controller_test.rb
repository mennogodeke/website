require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "experience page returns success" do
    get experience_url
    assert_response :success
  end

  test "experience page renders an expertise card for each expertise" do
    get experience_url
    assert_select ".expertise-card", count: Expertise.count
  end

  test "experience page renders a tag for each skill on an expertise" do
    get experience_url
    assert_select ".expertise-card-tags .tag", minimum: 1
  end
end
