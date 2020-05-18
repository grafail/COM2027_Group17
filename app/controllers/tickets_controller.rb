class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
    # #Temporary fix (Tests and route should be adjusted)
    @myTickets = if user_signed_in?
                   TicketsController.get_user_tickets(current_user.id)
                 else
                   []
                 end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show; end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit; end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        @event = Event.find(ticket_params[:event_id])
        format.html { redirect_to @event, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    params.require(:ticket).permit(:event_id, :price, :name, :description)
  end

  def self.get_user_tickets(id)
    ticket_list = []
    Order.where(user: id).each do |orderItem|
      ticket_list += Purchase.where(order: orderItem.id)
    end
    ticket_list
  end
  helper_method :get_user_tickets
end
