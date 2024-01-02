require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(username: "tolase", email: "lashe@foobar.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username length must not be more than 25" do
    @user.username = "a" * 26
    assert_not @user.valid?
  end

  test "username length must not be less that 3" do
    @user.username = "a" * 2
    assert_not @user.valid?
  end

  test "usernames should be lowcase" do
    mixed_case_username = "tOlASe"
    @user.username = mixed_case_username
    @user.save
    assert_equal mixed_case_username.downcase, @user.reload.username
  end

  test "usernames should be unique" do
    duplicate_user = @user.dup
    duplicate_user.username = "tolase"
    @user.username = "tolase"
    @user.save
    assert_not duplicate_user.valid?
  end

  test "associated project should be destroyed" do
    @user.save
    @user.projects.create!(name: "project one", description: "amazing one", github_link: "https://example.com")
    assert_difference 'Project.count', -1 do
      @user.destroy
    end
  end

end
