require "test_helper"

class ProjectsCreationTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:tolase)
    @project = projects(:orange)
  end

  test "create project with invalid information" do
    sign_in @user
    assert_no_difference 'Project.count' do
      post projects_path, params: { project: { name: "",
                                                github_link: "" } }
    end
    assert_response :unprocessable_entity
    assert_template "projects/new"
    assert_select "div#error_explanation"
  end

  test "create with valid information" do
    sign_in @user
    description = "My nice project"
    github_link = "https://www.example.com"
    assert_difference 'Project.count', 1 do
      post projects_path, params: { project: { name: "My project",
                                                github_link: github_link,
                                                description: description } }
    end
    follow_redirect!
    assert_template 'projects/show'
    assert_not flash.empty?
    assert_match description, response.body
    assert_match github_link, response.body
  end
end
