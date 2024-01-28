require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = users(:john)
    assert user.valid?
  end
  test 'invalid without email' do
    user = User.new(name: 'test', password: 'password', password_confirmation: 'password')
    refute user.valid?, 'user is valid without a name'
    assert_not_nil user.errors[:name], 'no validation error for name present'
  end
  test 'invalid with duplicate email' do
    user1 = users(:john)
    user2 = User.new(name: 'John2', email: user1.email, password: 'password', password_confirmation: 'password')
    refute user2.valid?
    assert_not_nil user2.errors[:email]
  end
  test 'invalid without password' do
    user = User.new(name: 'John', email: 'john@example.com')
    refute user.valid?
    assert_not_nil user.errors[:password]
  end
  test 'password should have a minimum length' do
    user = User.new(name: 'John', email: 'john@example.com', password: 'short', password_confirmation: 'short')
    refute user.valid?
    assert_not_nil user.errors[:password]
  end
end
