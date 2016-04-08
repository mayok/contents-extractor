require 'test_helper'

class AddPagesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "invalid page information" do
    assert_no_difference 'Page.count' do
      post user_pages_path(@user.id), page: { url: "" }
    end
  end

  test "url that contains special character also should be valid" do
    assert_difference 'Page.count' do
      log_in_as(@user)
      post user_pages_path(@user.id), page: { url: "https://ja.wikipedia.org/wiki/日本語" }
    end
  end
end
