require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "improper sign up information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {name: "",
                             email: "meh@com",
                             password: "234",
                             password_confirmation: "567" }
    end
    assert_template 'users/new'
  end

  test "proper sign up information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user:{name: "Mike Jones",
                                          email: "backthen@didntwantme.com",
                                          password: "nowimhottheyallonme",
                                          password_confirmation: "nowimhottheyallonme"}
    end
    # assert_template 'users/show'
    # assert is_logged_in?
  end
end
