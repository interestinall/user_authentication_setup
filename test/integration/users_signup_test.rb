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
end
