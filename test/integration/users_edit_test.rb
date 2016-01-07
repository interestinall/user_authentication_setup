require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:justin)
  end

  test "broken edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "",
                                    email: "fmeh@fjl",
                                    password: "hag",
                                    password_confirmation: "bag"  }
    assert_template 'users/edit'

  end


  test "working edit" do
      log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "FOO FEE"
    email = "foofee@foofoo.bar"
    patch user_path(@user), user: {name: name,
                                   email: email,
                                   password: "",
                                   password_confirmation: ""}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end


end
