class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def self.load_events(events)
    Gmaps4rails.build_markers(events) do |venue, marker|
      marker.lat venue.latitude
      marker.lng venue.longitude

      marker.infowindow venue.name
    end
  end

  def cheapestTicket(id)
    Ticket.where(event: id).minimum(:price)
  end
  helper_method :cheapestTicket

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
    results=[]
    distance = distance.to_i
    if distance.present? && location.present? && (distance != 0)
      coords = Geocoder.coordinates(location)
      events.each do |event|
        if(Geocoder::Calculations.distance_between([event.latitude,event.longitude],coords))<=distance
          results<<event
        end
      end
      Event.where(id: results.map(&:id))
    else
      events
    end

  end

  # GET /events
  # GET /events.json
  def index
    if not validateParameters

      redirect_to events_path, notice: 'Invalid values supplied!'

    end
    @eventsNoCategory = distanceCheck(betweenPrice(Event.in_dates(params[:startDate],params[:endDate]), params[:priceMin], params[:priceMax]),params[:distance],params[:location])
    @events = @eventsNoCategory.in_category(params[:category])
    @events_default = EventsController.load_events(@events)
    setFilterValues
  end

  def validateParameters
    #TODO: Add validation for parameters
    true
  end

  # Sets the values the filters will have
  def setFilterValues
    @minPrice = if params[:priceMin].present?
                  params[:priceMin]
                else
                  0
                end

    @maxPrice = if params[:priceMax].present?
                  params[:priceMax]
                else
                  maximumGlobalPrice
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
  end

  # GET /events/new
  def new
    if user_signed_in? && User.find_by(id:current_user.id).isBusiness? == true
      @event = Event.new
    else
      redirect_to root_path, notice: 'Please login into a business account'
    end
  end

  def myEvents
    if user_signed_in? && User.find_by(id:current_user.id).isBusiness?
      @myEvents = Event.where(user:current_user.id)
    else
      redirect_to root_path, notice: 'Please login into a business account'
    end
  end

  # GET /events/1/edit
  def edit; end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
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
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
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
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:user_id, :name, :description, :location, :eventType)
  end
end
