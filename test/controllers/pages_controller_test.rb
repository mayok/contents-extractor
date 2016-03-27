require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  fixtures :pages

  test "should get index" do
    get :index
    assert_response :success
  end

  # test "should get show" do
  #   get :show
  #   assert_response :success
  # end
end
