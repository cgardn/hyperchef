require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(email: "bob@gmail.com",
                     password: "passwordasdf",
                     password_confirmation: "passwordasdf")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should catch emails with more than one @" do
    @user.email = "j@j@j@....."
    assert_not @user.valid?
  end

  test "should catch emails with no TLD" do
    @user.email = "bob@jones"
    assert_not @user.valid?
  end

  test "should catch emails with no local username" do
    @user.email = "@jones.com"
    assert_not @user.valid?
  end

  test "should catch emails with no domain" do
    @user.email = "bob@.com"
    assert_not @user.valid?
  end

  test "should catch emails with whitespace intermixed in the address" do
    @user.email = "bo b@ df . com"
    assert_not @user.valid?
  end

  test "should catch passwords less than 10 chars long" do
    @user.password = "123456789"
    @user.password_confirmation = "123456789"
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "emails should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " "*10
    assert_not @user.valid?
  end

end
