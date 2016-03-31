require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  def setup
    @page = pages(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Page.count' do
      post :create, page: {
        title: "MyString",
        url: "http://www.example.com",
        content: "MyString"
      }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Page.count' do
      delete :destroy, id: @page
    end
    assert_redirected_to login_url
  end
end
