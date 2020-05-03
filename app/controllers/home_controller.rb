class HomeController < ApplicationController
  def home
    @events_default=EventsController.load_events
  end

  def contact
  end

  def about
  end

end
