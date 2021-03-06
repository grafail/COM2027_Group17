class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy list]

  def self.load_events(eventsList)
    Gmaps4rails.build_markers(eventsList) do |venue, marker|
      marker.lat venue.latitude
      marker.lng venue.longitude

      marker.infowindow venue.name
    end
  end

  def inCategory(events,category)
    if !category
      return events
    end
    return events.where(:eventType => Event.eventTypes[category])
  end

  def cheapestTicket(id)
    min = -1
    @allPurchases = []
    event = Event.find_by(id:id)
    tickets = Ticket.where(event:event)
    tickets.each do |ticket|
      tmp = TicketsController.ticketsRemaining(ticket.id)
      if tmp>0
        if min==-1 or min>ticket.price
          min = ticket.price
        end
      end
    end
    return min
  end
  helper_method :cheapestTicket

  def list
    @allPurchases = []
    tickets = Ticket.where(event:@event)
    tickets.each do |ticket|
      @allPurchases += Purchase.where(ticket:ticket)
    end
  end

  def betweenPrice(events, minPrice, maxPrice)
    results = []
    minPrice = minPrice.to_i if minPrice.present?

    maxPrice = maxPrice.to_i if maxPrice.present?
    events.each do |eventItem|
      next if Ticket.where(event: eventItem.id).empty?

      minTicket = cheapestTicket(eventItem.id)
      if minPrice.present? && maxPrice.present?
        results << eventItem if (minTicket >= minPrice) && (minTicket <= maxPrice)
      elsif minPrice.present?
        results << eventItem if minTicket >= minPrice
      elsif maxPrice.present?
        results << eventItem if minTicket <= maxPrice
      else
        results << eventItem
      end
    end

    Event.where(id: results.map(&:id))
  end

  def distanceCheck(events, distance, location)
    results = []
    distance = distance.to_i
    if distance.present? && location.present? && (distance != 0)
      coords = Geocoder.coordinates(location)
      events.each do |event|
        if (Geocoder::Calculations.distance_between([event.latitude, event.longitude], coords)) <= distance
          results << event
        end
      end
      Event.where(id: results.map(&:id))
    else
      events
    end

  end

  def nearby_events(currentEvent)
    results = []
    distance = 10
    if currentEvent.location.present? && (distance != 0)
      coords = Geocoder.coordinates(location)
      Event.all.each do |event|
        if currentEvent.id != event.id and (Geocoder::Calculations.distance_between([event.latitude, event.longitude], [currentEvent.latitude, currentEvent.longitude])) <= distance
          results << event
        end
      end
      Event.where(id: results.map(&:id))
    else
      Event.all
    end
  end

  # GET /events
  # GET /events.json
  def index

    validateParameters

    @eventsNoCategory = distanceCheck(betweenPrice(Event.in_dates(params[:beginDate], params[:endDate]), params[:priceMin], params[:priceMax]), params[:distance], params[:location])
    @events = inCategory(@eventsNoCategory,params[:category])
    @events_default = EventsController.load_events(@events)
    @events = sort_events(@events, params[:sort])

    setFilterValues
  end

  def sort_events(events, sort)
    if not sort.present?
      sort = 1
    elsif sort.to_i >= 1 and sort.to_i <= 6
      @sortNum = sort
    end
    case sort.to_i
    when 1
      @sort = 'Name (ascending)'
      events.sort { |a, b| a.name <=> b.name }
    when 2
      @sort = 'Name (descending)'
      events.sort { |a, b| b.name <=> a.name }
    when 3
      @sort = 'Price (ascending)'
      events.sort { |a, b| cheapestTicket(a.id) <=> cheapestTicket(b.id) }
    when 4
      @sort = 'Price (descending)'
      events.sort { |a, b| cheapestTicket(b.id) <=> cheapestTicket(a.id) }
    when 5
      @sort = 'Date (ascending)'
      events.sort { |a, b| a.eventDate <=> b.eventDate }
    when 6
      @sort = 'Date (descending)'
      events.sort { |a, b| b.eventDate <=> a.eventDate }
    else
      @sort = ''
      events
    end
  end

  def validateParameters
    if params[:category] and not Event.eventTypes.keys().include?(params[:category])
      params.delete("category")
    end

    if params[:beginDate] and not params[:beginDate].match("[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}")
      params.delete("beginDate")
    end

    if params[:endDate] and not params[:endDate].match("[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}")
      params.delete("endDate")
    end

  end

  # Sets the values the filters will have
  def setFilterValues
    @maxPriceGlobal = maximumGlobalPrice
    @minPrice = if params[:priceMin].present?
                  params[:priceMin]
                else
                  0
                end

    @maxPrice = if params[:priceMax].present?
                  params[:priceMax]
                else
                  @maxPriceGlobal
                end
    if params[:beginDate]
      @beginDate = params[:beginDate]
    end
    if params[:endDate]
      @endDate = params[:endDate]
    end

    if params[:category]
      @category = params[:category]
    end

    if params[:page] and params[:page].match("[0-9]+") and (params[:page].to_i - 1) * 2 < @events.length and params[:page].to_i >= 1
      @page = params[:page].to_i
    else
      @page = 1
    end

  end

  # Maximum price across all tickets
  def maximumGlobalPrice
    Ticket.all.maximum(:price)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @eventsNearby = nearby_events(@event)
  end

  # GET /events/new
  def new
    if user_signed_in? && current_user.isBusiness? == true
      @event = Event.new
    else
      redirect_to root_path, notice: 'Please login into a business account'
    end
  end

  def myEvents
    if user_signed_in? && current_user.isBusiness?
      @myEvents = Event.where(user: current_user.id)
    else
      redirect_to root_path, notice: 'Please login into a business account'
    end
  end

  # GET /events/1/edit
  def edit
    if !(user_signed_in? && current_user.isBusiness? == true)
      redirect_to root_path, notice: 'Please login into a business account'
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to new_ticket_path(event_id: @event), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to '/myevents', notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if user_signed_in? && current_user.isBusiness? == true && current_user == @event.user
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, notice: 'Please login into your business account'
    end
  end

  def self.isSoldOut(event)
    tickets = Ticket.where(event:event)
    tickets.each do |ticket|
      if TicketsController.ticketsRemaining(ticket.id)!=0
        return false
      end
    end
    return true
  end
  helper_method :isSoldOut

  def self.findEventImage(event)

    if event.Music?
      "music.png"
    elsif event.Sports?
      "sports.png"
    elsif event.Charitable?
      "charitable.png"
    elsif event.Hobby?
      "hobby.png"
    elsif event.Religious?
      "religious.png"
    else
      "misc.png"
    end
  end

  helper_method :findEventImage

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:user_id, :name, :description, :location, :eventType, :eventDate)
  end
end
