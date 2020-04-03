require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:one)
    @ticket = tickets(:one)

  end

  test 'should save valid purchase' do
    purchase = Purchase.new

    purchase.user_id = @user.id
    purchase.ticket_id = @ticket.id
    purchase.comments = 'comment'
    purchase.PriceTotal = 100.0

    purchase.save
    assert purchase.valid?
  end

  test 'should not save empty purchase' do
    purchase = Purchase.new

    purchase.save
    refute purchase.valid?
  end

  test 'should not save duplicate purchase' do
    purchase = Purchase.new
    purchase.user_id = @user.id
    purchase.ticket_id = @ticket.id
    purchase.comments = 'comment'
    purchase.PriceTotal = 100
    purchase.save

    purchase2 = Purchase.new
    purchase2.user_id = @user.id
    purchase2.ticket_id = @ticket.id
    purchase2.comments = 'comment'
    purchase2.PriceTotal = 100
    purchase2.save
    refute purchase2.valid?
  end

  test 'should not save without user' do
    purchase = Purchase.new
    purchase.ticket_id = @ticket.id
    purchase.comments = 'comment'
    purchase.PriceTotal = 100
    purchase.save
    refute purchase.valid?
  end

  test 'should not save without ticket' do
    purchase = Purchase.new
    purchase.user_id = @user.id
    purchase.comments = 'comment'
    purchase.PriceTotal = 100
    purchase.save
    refute purchase.valid?
  end
end
