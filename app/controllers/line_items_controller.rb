class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:create]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    ticket = Ticket.find(params[:ticket_id])
    @line_item = @cart.line_items.build(ticket: ticket)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to ticket, notice: 'Added to cart successfully.' }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to Cart.all[0], notice: 'Removed from cart successfully.'}
      format.json { head :no_content }
    end
  end

  def emptyCart
    LineItem.all.each do |item|
      item.destroy
    end
    respond_to do |format|
      format.html { redirect_to Cart.all[0], notice: 'Cart emptied successfully.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    #If no existing session, before creating a new cart, you delete any existing ones
    Cart.all.each do |cart|
      cart.destroy
    end
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:ticket_id, :cart_id)
    end
end
