require "test_helper"

class JobTest < ActiveSupport::TestCase
  test "valid with all required fields" do
    job = Job.new(title: "Engineer", company: "Acme", start_date: Date.today)
    assert job.valid?
  end

  test "invalid without title" do
    job = Job.new(company: "Acme", start_date: Date.today)
    assert_not job.valid?
  end

  test "invalid without company" do
    job = Job.new(title: "Engineer", start_date: Date.today)
    assert_not job.valid?
  end

  test "invalid without start_date" do
    job = Job.new(title: "Engineer", company: "Acme")
    assert_not job.valid?
  end

  test "valid without end_date" do
    job = Job.new(title: "Engineer", company: "Acme", start_date: Date.today, end_date: nil)
    assert job.valid?
  end
end
