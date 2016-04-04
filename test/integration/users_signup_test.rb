require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "baz"
      }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Example User 1",
                                            email: "user@example.com",
                                            password: "foobarbaz",
                                            password_confirmation: "foobarbaz"
      }
    end
    assert_template 'static_pages/home'
    assert is_logged_in?
  end
end
