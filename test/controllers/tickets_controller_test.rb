require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @ticket = tickets(:one)
    @user = users(:one)
    @event = events(:one)
    login_as @user
  end

  test "should get index" do
    get tickets_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_url
    assert_response :success
  end

   test "should create ticket" do
    assert_difference('Ticket.count') do
      post tickets_url, params: { ticket: { description: @ticket.description, event_id: @ticket.event_id, name: @ticket.name, price: @ticket.price, quantity: @ticket.quantity } }
    end

   assert_redirected_to '/myevents'
   end

  test "should show ticket" do
    get ticket_url(@ticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_url(@ticket)
    assert_response :success
  end

  test "should update ticket" do
    patch ticket_url(@ticket), params: { ticket: { description: @ticket.description, event_id: @ticket.event_id, name: @ticket.name, price: @ticket.price, quantity: @ticket.quantity  } }
    assert_redirected_to '/myevents'
  end

  test "should destroy ticket" do
    assert_difference('Ticket.count', -1) do
      delete ticket_url(@ticket)
    end

    assert_redirected_to '/myevents'
  end
end
