require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "gets index" do
    get projects_url
    assert_response :success
  end

  test "index lists all projects" do
    get projects_url
    assert_response :success
  end

  test "gets show" do
    get project_url(projects(:menno_codes))
    assert_response :success
  end

  test "show displays project name" do
    get project_url(projects(:menno_codes))
    assert_select "h1", text: projects(:menno_codes).name
  end
end
