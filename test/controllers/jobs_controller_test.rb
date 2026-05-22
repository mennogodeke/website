require "test_helper"

class JobsControllerTest < ActionDispatch::IntegrationTest
  test "gets index" do
    get jobs_url
    assert_response :success
  end

  test "index lists jobs ordered by start_date descending" do
    get jobs_url
    assert_select ".tl-entry", count: Job.count
  end
end
