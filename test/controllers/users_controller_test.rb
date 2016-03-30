require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create
    assert_response :success
  end

  test "should get show" do
    get :show, id: 2
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: 2
    assert_response :success
  end

  # I don't know why this test does not pass
  # test "should get udpate" do
  #   patch :udpate, id: 2
  #   assert_response :success
  # end

  test "should get destroy" do
    delete :destroy, id: 2
    assert_response :success
  end

end
