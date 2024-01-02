require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:archer)
    @tag = tags(:tag_one)
  end

  test "should get index" do
    get tags_url
    assert_response :success
  end

  test "should redirect new when user is not logged in" do
    get new_tag_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should redirect create when not logged in" do
    get new_tag_path
    assert_no_difference "Tag.count" do
      post tags_path, params: { tag: { name: "html", category: "general" } }
    end
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should redirect edit when not logged in" do
    get edit_tag_path(@tag)
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
  end

  test "should redirect update when not logged in" do
    @tag.name = "HTML"
    patch tag_path(@tag), params: { tag: { name: "CSS" } }
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
    assert_equal @tag.name, "HTML"
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Tag.count' do
      delete tag_path(@tag)
    end
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
  end

  test "should redirect new when not admin" do
    sign_in @user
    get new_tag_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect create when not admin" do
    sign_in @user
    assert_no_difference "Tag.count" do
      post tags_path, params: { tag: { name: "html", category: "general" } }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when not admin" do
    sign_in @user
    get edit_tag_path(@tag)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not admin" do
    sign_in @user
    @tag.name = "HTML"
    patch tag_path(@tag), params: { tag: { name: "CSS" } }
    assert_not flash.empty?
    assert_redirected_to root_url
    assert_equal @tag.name, "HTML"
  end

  test "should redirect destroy when not admin" do
    sign_in @user
    assert_no_difference 'Tag.count' do
      delete tag_path(@tag)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
