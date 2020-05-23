require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  setup do
    @ticket = tickets(:one)
    @order = orders(:one)
  end

  test 'should save valid purchase' do
    purchase = Purchase.new

    purchase.ticket_id = @ticket.id
    purchase.order_id = @order.id
    purchase.qty = 10

    purchase.save
    assert purchase.valid?
  end

  test 'should not save empty purchase' do
    purchase = Purchase.new

    purchase.save
    refute purchase.valid?
  end

  test 'should not save negative quantity' do
    purchase = Purchase.new
    purchase.ticket_id = @ticket.id
    purchase.order_id = @order.id
    purchase.qty = -5
    purchase.save
    refute purchase.valid?
  end

  test 'should not save purchase without order' do
    purchase = Purchase.new
    purchase.ticket_id = @ticket.id
    purchase.qty = 10
    purchase.save
    refute purchase.valid?
  end

  test 'should not save purchase without ticket' do
    purchase = Purchase.new
    purchase.order_id = @order.id
    purchase.qty = 10
    purchase.save
    refute purchase.valid?
  end

  test 'should not save purchase without quantity' do
    purchase = Purchase.new
    purchase.ticket_id = @ticket.id
    purchase.order_id = @order.id
    purchase.save
    refute purchase.valid?
  end


end
