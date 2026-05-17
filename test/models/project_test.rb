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

  test "valid with https url and repo_url" do
    project = Project.new(name: "My Project", url: "https://example.com", repo_url: "https://github.com/user/repo")
    assert project.valid?
  end

  test "valid with http url" do
    project = Project.new(name: "My Project", url: "http://example.com")
    assert project.valid?
  end

  test "invalid url scheme is rejected" do
    project = Project.new(name: "My Project", url: "javascript:alert(1)")
    assert_not project.valid?
    assert_includes project.errors[:url], "must be a valid HTTP or HTTPS URL"
  end

  test "invalid repo_url scheme is rejected" do
    project = Project.new(name: "My Project", repo_url: "javascript:alert(1)")
    assert_not project.valid?
    assert_includes project.errors[:repo_url], "must be a valid HTTP or HTTPS URL"
  end

  test "malformed url is rejected" do
    project = Project.new(name: "My Project", url: "not a url")
    assert_not project.valid?
    assert_includes project.errors[:url], "must be a valid HTTP or HTTPS URL"
  end

  test "has many skills through project_skills" do
    project = projects(:menno_codes)
    assert_includes project.skills, skills(:ruby_on_rails)
  end

  test "ordered by position ascending" do
    ordered = Project.all.to_a
    assert_equal projects(:menno_codes), ordered.first
    assert_equal projects(:poolbar), ordered.last
  end
end
