require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  def setup
    @user = users(:tolase)
    @project = @user.projects.build(name: "My awesome project", description: "This project is just too amazing", github_link: "https://example.com")
  end

  test "project is valid" do
    assert @project.valid?
  end

  test "name should be present" do
    @project.name = "  "
    assert_not @project.valid?
  end

  test "description should be present" do
    @project.description = "  "
    assert_not @project.valid?
  end

  test "github link should be present" do
    @project.github_link = "  "
    assert_not @project.valid?
  end
end
