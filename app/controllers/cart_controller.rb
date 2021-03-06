class CartController < ApplicationController

  def cart
    @cartItems = CartController.all_cart_items(session)
    @total = CartController.total_price_cart(session)
  end

  def check_cart
    session[:cart] = {} unless session[:cart]
  end

  def self.check_cart(session)
    if session.blank?
      session = {}
    end
    session[:cart] = {} unless session[:cart]
    return session
  end
  helper_method :check_cart

  def change_qty
    check_cart
    id = params[:id]
    @ticket = Ticket.find_by_id(id)
    @event = @ticket.event
    user = User.find_by_id(session[:user_id])
    if @event.blank? or (user and user.isBusiness? and @event.user!=user.id)
      redirect_to root_path, notice: 'Business user can only buy their own tickets'
      return
    end
    qty = params[:qty].to_i
    if qty <= TicketsController.ticketsRemaining(@ticket)
      session[:cart][id] = qty
      msg = 'Ticket was added!'
    else
      msg = 'Ticket could not be added!'
    end

    if qty == 0
      redirect_to cart_remove_path(id: id)
      return
    end

    respond_to do |format|
      format.html { redirect_to '/cart', notice: msg }
    end
  end

  def remove
    check_cart
    id = params[:id]
    session[:cart].delete(id) if session[:cart][id]
    respond_to do |format|
      format.html { redirect_to '/cart', notice: 'Ticket was removed!' }
    end
  end

  def set_quantity
    check_cart
    id = params[:id]
    qty = params[:qty]
    if qty > 0
      session[:cart][id] = qty
      msg = 'Ticket quantity was changed!'
    else
      msg = 'Ticket quantity was not changed!'
    end
    session[:cart][id] = qty
    respond_to do |format|
      format.html { redirect_to '/cart', notice: msg }
    end
  end

  def clear
    session[:cart] = {}
    respond_to do |format|
      format.html { redirect_to '/cart', notice: 'Cart emptied successfully.' }
    end
  end

  def self.all_cart_items(session)
    session = check_cart(session)
    all_tickets=[]
    if session[:'warden.user.user.key'].present?
      user = User.find_by_id(session[:'warden.user.user.key'][0][0])
    else
      user = nil
      end
    session[:cart].each do |item|
      ticket = Ticket.find_by(id:item[0].to_i)
      if !ticket.blank? and TicketsController.ticketsRemaining(ticket.id)>=item[1] and !(!user.blank? and user.isBusiness? and ticket.event.user.id!=user.id)
        all_tickets<<item
      else
        session[:cart].delete(item[0])
      end
    end
    return all_tickets
  end
  helper_method :all_cart_items

  def self.length_of_cart(session)
    session = check_cart(session)
    all_cart_items(session).length
  end
  helper_method :length_of_cart

  def self.total_price_cart(session)
    return 0 unless session[:cart]

    total = 0
    all_cart_items(session).each do |item|
      id = item[0]
      qty = item[1].to_i
      ticket = Ticket.find_by(id: id)
      total += ticket.price * qty
    end
    total
  end
  helper_method :total_price_cart
end
