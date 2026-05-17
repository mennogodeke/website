require "test_helper"

class JobsHelperTest < ActionView::TestCase
  test "returns formatted month and year when date is present" do
    assert_equal "Jan 2023", job_end_date(Date.new(2023, 1, 1))
  end

  test "returns Present when date is nil" do
    assert_equal "Present", job_end_date(nil)
  end
end
