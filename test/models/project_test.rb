require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "valid with name" do
    project = Project.new(name: "My Project")
    assert project.valid?
  end

  test "invalid without name" do
    project = Project.new(name: nil)
    assert_not project.valid?
  end

  test "optional fields can be blank" do
    project = Project.new(name: "My Project", url: nil, repo_url: nil, year: nil, position: nil)
    assert project.valid?
  end

  test "has many skills through project_skills" do
    project = projects(:menno_codes)
    assert_includes project.skills, skills(:ruby_on_rails)
  end

  test "ordered by position ascending" do
    ordered = Project.all.to_a
    assert_equal projects(:menno_codes), ordered.first
    assert_equal projects(:placeholder), ordered.last
  end
end
