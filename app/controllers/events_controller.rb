class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]



  # GET /events
  # GET /events.json
  def index
    # @events_default=EventsController.load_events
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    if user_signed_in? && User.find_by(id:current_user.id).isBusiness == true
      @event = Event.new
    else
      redirect_to root_path, notice: 'Please login into a business account' unless user_signed_in?
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    if user_signed_in?
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

  def myEvents
    if user_signed_in? && User.find_by(id:current_user.id).isBusiness
      @myEvents = Event.where(user:current_user.id)
    else
      redirect_to root_path, notice: 'Please login into a business account' unless user_signed_in?
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:user_id, :name, :description, :eventType, :location, :eventDate)
    end
end
