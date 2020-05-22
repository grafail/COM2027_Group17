require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  setup do
    @event = events(:one)
  end

  test 'should save valid ticket' do
    ticket = Ticket.new

    ticket.event_id = @event.id
    ticket.price = 50
    ticket.description = 'description'
    ticket.name = 'name'
    ticket.quantity = 1

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
    ticket.quantity = 1

    ticket.save
    refute ticket.valid?
  end

  test 'should not save ticket without price' do
    ticket = Ticket.new

    ticket.event_id = @event.id
    ticket.description = 'description'
    ticket.name = 'name'
    ticket.quantity = 1

    ticket.save
    refute ticket.valid?
  end

  test 'should not save ticket without name' do
    ticket = Ticket.new

    ticket.event_id = @event.id
    ticket.price = 50
    ticket.description = 'description'
    ticket.quantity = 1

    ticket.save
    refute ticket.valid?
  end

  test 'should not save ticket without quantity' do
    ticket = Ticket.new

    ticket.name = 'Ticket1'
    ticket.event_id = @event.id
    ticket.price = 50
    ticket.description = 'description'

    ticket.save
    refute ticket.valid?
  end

  test 'should not save ticket with negative quantity' do
    ticket = Ticket.new

    ticket.name = 'Ticket1'
    ticket.event_id = @event.id
    ticket.price = 50
    ticket.description = 'description'
    ticket.quantity = -1

    ticket.save
    refute ticket.valid?
  end
end
