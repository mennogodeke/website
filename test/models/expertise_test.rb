require "test_helper"

class ExpertiseTest < ActiveSupport::TestCase
  test "valid with all required fields" do
    expertise = Expertise.new(name: "Back-end", years_of_experience: 8)
    assert expertise.valid?
  end

  test "invalid without name" do
    expertise = Expertise.new(years_of_experience: 8)
    assert_not expertise.valid?
  end

  test "invalid without years_of_experience" do
    expertise = Expertise.new(name: "Back-end")
    assert_not expertise.valid?
  end

  test "ordered by years_of_experience descending by default" do
    ordered = Expertise.all.map(&:years_of_experience)
    assert_equal ordered.sort.reverse, ordered
  end

  test "has many skills through expertise_skills" do
    expertise = expertises(:backend)
    assert_includes expertise.skills, skills(:ruby_on_rails)
  end
end