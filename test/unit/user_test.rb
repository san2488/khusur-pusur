require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save without email" do
  user = User.new
  assert !user.save, "Saved user without email"
  end

  test "should not save without password" do
  user = User.new
  assert !user.save, "Saved user without password"
  end
end
