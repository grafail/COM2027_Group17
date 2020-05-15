class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def self.load_events(events)
    return Gmaps4rails.build_markers(events) do |venue, marker|
      marker.lat venue.latitude
      marker.lng venue.longitude

      marker.infowindow venue.name
    end
  end

  def cheapestTicket(id)
    Ticket.where(event:id).minimum(:price)
  end
  helper_method :cheapestTicket

  def betweenPrice(events, minPrice,maxPrice)
    results = []
    if minPrice.present?
      minPrice = minPrice.to_i
    end

    if maxPrice.present?
      maxPrice = maxPrice.to_i
    end
    events.each do |eventItem|
      if(Ticket.where(event:eventItem.id).length==0)
        next
      end
      minTicket = cheapestTicket(eventItem.id)
        if minPrice.present? and maxPrice.present?
          if(minTicket >= minPrice and minTicket <= maxPrice)
            results<<eventItem
          end
        elsif minPrice.present?
          if(minTicket >= minPrice)
            results<<eventItem
          end
        elsif maxPrice.present?
          if(minTicket <= maxPrice)
            results<<eventItem
          end
        else
          results<<eventItem
        end
    end

    return Event.where(id: results.map(&:id))

  end

  def distanceCheck(events,distance)
    if(distance.present? and distance.to_i!=0)
      events.each do |event|

      end
    else
      return events
    end
  end

  # GET /events
  # GET /events.json
  def index

    @eventsNoCategory = betweenPrice(Events.all,params[:priceMin],params[:priceMax])
    @events = @eventsNoCategory.in_category(params[:category])
    @events_default=EventsController.load_events(@events)
    setFilterValues()

  end

  #Sets the values the filters will have
  def setFilterValues
    if params[:priceMin].present?
      @minPrice = params[:priceMin]
    else
      @minPrice = 0
    end

    if params[:priceMax].present?
      @maxPrice = params[:priceMax]
    else
      @maxPrice = maximumGlobalPrice()
    end
  end

  #Maximum price across all tickets
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
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

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
