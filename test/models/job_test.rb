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

  test "has many skills through job_skills" do
    job = jobs(:kape_senior)
    assert_includes job.skills, skills(:ruby_on_rails)
  end

  # ── Traco locale translations ────────────────────────────────────────────────

  test "title returns Dutch translation in nl locale" do
    job = jobs(:kape_senior)
    I18n.with_locale(:nl) { assert_equal job.title_nl, job.title }
  end

  test "title returns German translation in de locale" do
    job = jobs(:kape_senior)
    I18n.with_locale(:de) { assert_equal job.title_de, job.title }
  end

  test "title falls back to English when Dutch translation is blank" do
    job = jobs(:kape_senior)
    job.title_nl = nil
    I18n.with_locale(:nl) { assert_equal job.title_en, job.title }
  end

  test "description falls back to English when German translation is blank" do
    job = jobs(:kape_senior)
    job.description_de = nil
    I18n.with_locale(:de) { assert_equal job.description_en, job.description }
  end
end
