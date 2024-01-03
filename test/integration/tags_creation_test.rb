require "test_helper"

class TagsCreationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    # @tag = tags(:tag_one)
    sign_in @user
  end

  # test "invalid create information" do
  #   get new_tag_path
  #   assert_template 'tags/new'
  #   assert_no_difference 'Tag.count' do
  #     post tags_path, params: { tag: { name: "" } }
  #   end
  #   assert_response :unprocessable_entity
  #   assert_template 'tags/new'
  # end

  test "valid create information" do
    get new_tag_path
    assert_template 'tags/new'
    assert_difference 'Tag.count', 1 do
      post tags_path, params: { tag: { name: "bcos" } }
    end
    # @tag = assigns(:tag)
    # follow_redirect!
    # assert_template 'tags/show'
  end
end
