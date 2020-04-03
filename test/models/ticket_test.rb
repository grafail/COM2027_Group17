require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @event = events(:one)
  end

  test 'should save valid ticket' do
    ticket = Ticket.new

    ticket.event_id = @event.id
    ticket.price = 50
    ticket.description = 'description'
    ticket.name = 'name'

    ticket.save
    assert ticket.valid?
  end

  test 'should not save empty ticket' do
    ticket = Ticket.new

    ticket.save
    refute ticket.valid?
  end

  test 'should not save ticket without event' do
    ticket = Ticket.new

    ticket.price = 50
    ticket.description = 'description'
    ticket.name = 'name'

    ticket.save
    refute ticket.valid?
  end

  test 'should not save ticket without price' do
    ticket = Ticket.new

    ticket.event_id = @event.id
    ticket.description = 'description'
    ticket.name = 'name'

    ticket.save
    refute ticket.valid?
  end

  test 'should not save ticket without name' do
    ticket = Ticket.new

    ticket.event_id = @event.id
    ticket.price = 50
    ticket.description = 'description'

    ticket.save
    refute ticket.valid?
  end
end
