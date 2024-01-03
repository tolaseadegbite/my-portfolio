require "test_helper"

class TagDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)  
    @tag = tags(:tag_one)  
    sign_in @user
  end

  test "should destroy tag" do
    assert_difference 'Tag.count', -1 do
      delete tag_path(@tag)
    end
    assert_redirected_to tags_url
  end
end
