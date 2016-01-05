require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Mary Brown", email: "mbrown@exampleuser.com")
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

end
