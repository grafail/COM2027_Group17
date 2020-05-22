require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save invalid user' do
    user = User.new
    user.save
    refute user.valid?
  end

  test 'should save valid user' do
    user = User.new
    user.email = 'bob@example.com'
    user.password = '12345678'
    user.isBusiness = 'true'
    user.save
    assert user.valid?
  end

  test 'should not save user without business status' do
    user = User.new
    user.email = 'bob@example.com'
    user.password = '12345678'
    user.save
    refute user.valid?
  end
end
