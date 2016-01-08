require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Mary Brown", email: "mbrown@exampleuser.com", password: "mehmeh!99", password_confirmation: "mehmeh!99")
  end

  test "shoud be valid" do
    assert @user.valid?
  end

  test "name must be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email must be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name cannot be too long" do
    @user.name = "z" * 51
    assert_not @user.valid?
  end

  test "email cannot be too long" do
    @user.email = "e" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "should accept valid emails" do
    good_emails = %w[justin@lefurjah.me myfriend@gmail.com gooner4lyfe@arsenal.com]

    good_emails.each do |good_email|
      @user.email = good_email
      assert @user.valid? "#{good_email.inspect} should be valid"
    end
  end

  test "should reject obviously invalid emails" do
    crap_emails = %w[jerk00favabeansorg mehmeh@snaggletooth-info charles@gmail]

    crap_emails.each do |crap_email|
      @user.email = crap_email
      assert_not @user.valid? "#{crap_email.inspect} should be invalid"
    end
  end

  test "email address must be unique" do
    double_user = @user.dup
    double_user.email = @user.email.upcase
    @user.save
    assert_not double_user.valid?
  end

  test "user password should have min length" do
    @user.password = @user.password_confirmation = "a"*5
    assert_not @user.valid?
  end


  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

end
