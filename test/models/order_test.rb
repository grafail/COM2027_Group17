require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test 'should save valid order' do
    order = Order.new

    order.user_id = @user.id
    order.PriceTotal = 100

    order.save
    assert order.valid?
  end

  test 'should not save empty order' do
    order = Order.new

    order.save
    refute order.valid?
  end

  test 'should not save order without user' do
    order = Order.new
    order.PriceTotal = 100

    order.save
    refute order.valid?
  end

  test 'should not save order with price total lower than 0' do
    order = Order.new
    order.user_id = @user.id
    order.PriceTotal = -5

    order.save
    refute order.valid?
  end

  test 'should not save order without price total' do
    order = Order.new
    order.user_id = @user.id

    order.save
    refute order.valid?
  end

end
