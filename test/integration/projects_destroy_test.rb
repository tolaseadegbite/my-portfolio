require "test_helper"

class ProjectsDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @project = projects(:orange)
    @user = users(:tolase)
  end

  test "destroy project" do
    sign_in @user
    assert_difference 'Project.count', -1 do
      delete project_path(@project)
    end
    assert_not flash.empty?
    assert_redirected_to projects_url
    follow_redirect!
  end
end
