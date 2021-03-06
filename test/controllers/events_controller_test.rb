require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @event = events(:one)
    @ticket = tickets(:one)
    @user = users(:one)
    login_as @user

  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    #TODO: Log in as a business user first
    get new_event_url
      #assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { description: @event.description, location: @event.location, name: @event.name, user_id: @event.user_id, eventType: @event.eventType, eventDate: @event.eventDate } }
    end

    assert_redirected_to new_ticket_path(event_id: Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { description: @event.description, location: @event.location, name: @event.name, user_id: @event.user_id, eventType: @event.eventType } }
    assert_redirected_to '/myevents'
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
