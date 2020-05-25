class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy list]

  # GET /tickets
  # GET /tickets.json
  def index
    redirect_to root_path, notice: 'You should be logged in!' unless user_signed_in?
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
  def show
    redirect_to root_path, notice: 'You should be logged in to your business account!' unless user_signed_in? and current_user==@ticket.event.user
  end

  def list
    @ticketsBought = Purchase.where(ticket:@ticket)
  end
  # GET /tickets/new
  def new
    if user_signed_in? && User.find_by(id:current_user.id).isBusiness
      @ticket = Ticket.new
    else
      redirect_to root_path, notice: 'Please login into a business account' unless user_signed_in?
    end
  end

  # GET /tickets/1/edit
  def edit; end

  def self.ticketsSold(id)
    return Purchase.where(ticket:id).sum(:qty)
  end
  helper_method :ticketsSold

  def self.ticketsRemaining(id)
    ticket = Ticket.find_by(id:id)
    return ticket.quantity-ticketsSold(ticket.id)
  end
  helper_method :ticketsRemaining

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        @event = Event.find(ticket_params[:event_id])
        format.html { redirect_to '/myevents', notice: 'Ticket was successfully created.' }
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
    if not user_signed_in? or !@ticket or current_user.id!=@ticket.event.user.id
      redirect_to root_path, notice: 'Unauthorised action'
      return
    end
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to myevents_url, notice: 'Ticket was successfully updated.' }
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
    if not user_signed_in? or !@ticket or current_user.id!=@ticket.event.user.id
      redirect_to root_path, notice: 'Unauthorised action'
      return
    end
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to myevents_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id]) rescue nil
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    params.require(:ticket).permit(:event_id, :price, :name, :description, :quantity)
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
