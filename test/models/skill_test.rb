require "test_helper"

class SkillTest < ActiveSupport::TestCase
  test "valid with all required fields" do
    skill = Skill.new(name: "Ruby", level: :expert)
    assert skill.valid?
  end

  test "valid without description" do
    skill = Skill.new(name: "Ruby", level: :proficient)
    assert skill.valid?
  end

  test "invalid without name" do
    skill = Skill.new(level: :proficient)
    assert_not skill.valid?
  end

  test "invalid without level" do
    skill = Skill.new(name: "Ruby")
    assert_not skill.valid?
  end

  test "invalid level raises ArgumentError" do
    assert_raises(ArgumentError) { Skill.new(name: "Ruby", level: :godlike) }
  end
end
