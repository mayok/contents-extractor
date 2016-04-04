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
end
