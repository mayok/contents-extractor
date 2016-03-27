require 'test_helper'

class AddPagesTest < ActionDispatch::IntegrationTest
  test "invalid page information" do
    assert_no_difference 'Page.count' do
      post pages_path, page: { url: "" }
    end
  end
end
