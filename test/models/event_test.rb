require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @user = users(:one)
    @normUser = users(:three)
  end

  test 'should save valid event' do
    event = Event.new

    event.user_id = @user.id
    event.name = 'newEvent'
    event.description = 'description'
    event.location = '130 Weston Road, GU2 8AW'
    event.eventType = 1
    event.eventDate = "2021-12-25 18:00:00"

    event.save
    assert event.valid?
  end

  test 'should not save empty event' do
    event = Event.new

    event.save
    refute event.valid?
  end

  test 'should not save event without seller' do
    event = Event.new
    event.name = 'newEvent'
    event.description = 'description'
    event.location = '130 Weston Road, GU2 8AW'

    event.save
    refute event.valid?
  end

  test 'should not save event without name' do
    event = Event.new
    event.user_id = @user.id
    event.description = 'description'
    event.location = '130 Weston Road, GU2 8AW'
    event.eventType = 1
    event.eventDate = "2021-12-25 18:00:00"

    event.save
    refute event.valid?
  end

  test 'should not save event without location' do
    event = Event.new
    event.user_id = @user.id
    event.name = 'newEvent'
    event.description = 'description'
    event.eventType = 1
    event.eventDate = "2021-12-25 18:00:00"

    event.save
    refute event.valid?
  end

  test 'should not save date in future' do
    event = Event.new
    event.user_id = @user.id
    event.name = 'newEvent'
    event.description = 'description'
    event.eventType = 1
    event.eventDate = "2018-12-25 18:00:00"
    event.location = '130 Weston Road, GU2 8AW'

    event.save
    refute event.valid?
  end

  test 'should not save new event if not business' do
    event = Event.new
    event.user_id = @normUser.id
    event.name = 'newEvent'
    event.description = 'description'
    event.location = '130 Weston Road, GU2 8AW'
    event.eventType = 1
    event.eventDate = "2021-12-25 18:00:00"

    event.save
    refute event.valid?
  end
end
