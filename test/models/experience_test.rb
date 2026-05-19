require "test_helper"

class ExperienceTest < ActiveSupport::TestCase
  test "valid with all required fields" do
    experience = Experience.new(name: "Back-end", years_of_experience: 8)
    assert experience.valid?
  end

  test "invalid without name" do
    experience = Experience.new(years_of_experience: 8)
    assert_not experience.valid?
  end

  test "invalid without years_of_experience" do
    experience = Experience.new(name: "Back-end")
    assert_not experience.valid?
  end

  test "ordered by years_of_experience descending by default" do
    ordered = Experience.all.map(&:years_of_experience)
    assert_equal ordered.sort.reverse, ordered
  end

  test "has many skills through experience_skills" do
    experience = experiences(:backend)
    assert_includes experience.skills, skills(:ruby_on_rails)
  end
end
