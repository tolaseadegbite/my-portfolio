require "test_helper"

class TagEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)  
    @tag = tags(:tag_one)  
    sign_in @user
  end

  test "edit tag with invalid information" do
    get edit_tag_path(@tag)
    assert_template 'tags/edit'
    patch tag_path(@tag), params: { tag: { name: "", category: "project" } }
    # assert_not flash.empty?
    assert_template 'tags/edit'
  end

  test "edit tag with valid information" do
    get edit_tag_path(@tag)
    assert_template 'tags/edit'
    @tag.name = "Tailwind"
    patch tag_path(@tag), params: { tag: { name: @tag.name } }
    assert_redirected_to @tag
    @tag.reload
    assert_equal @tag.name, 'Tailwind'.downcase
  end
end
