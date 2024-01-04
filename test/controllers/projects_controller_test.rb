require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:tolase)
    @other_user = users(:archer)
    @project = projects(:orange)
  end

  test "should get new" do
    sign_in @user
    get new_project_path
    assert_response :success
    assert_select "title", "New project | Tolase Kelvin Adegbite"
  end

  test "should redirect new when not logged in" do
    get new_project_path
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Project.count' do
      post projects_path, params: { project: { name: "Awesome project" } }
    end
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect edit when not logged in" do
    get edit_project_path(@project)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect edit when logged in as wrong user" do
    sign_in @other_user
    get edit_project_path(@project)
    assert_response :see_other
    assert_redirected_to projects_url
    assert_not flash.empty?
  end

  test "should redirect update when not logged in" do
    assert_no_difference 'Project.count' do
      patch project_path(@project), params: { project: { name: "Awesome project" } }
    end
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect update when logged in as wrong user" do
    sign_in @other_user
    patch project_path(@project), params: { project: { name: "A name" } }
    assert_response :see_other
    assert_redirected_to projects_url
    assert_not flash.empty?
  end

  test "redirect destroy when not logged in" do
    assert_no_difference "Project.count" do
      delete project_path(@project)
    end
    assert_redirected_to new_user_session_url
  end

  test "redirect destroy when logged in as wrong user" do
    sign_in @other_user
    assert_no_difference "Project.count" do
      delete project_path(@project)
    end
    assert_response :see_other
    assert_redirected_to projects_url
    assert_not flash.empty?
  end

  test "should redirect destroy when logged in as a non-admin" do
    sign_in @other_user
    assert_no_difference "Project.count" do
      delete project_path(@project)
    end
    assert_redirected_to projects_url
    assert_not flash.empty?
  end
end
