class CartController < ApplicationController

  def check_cart
    if !session[:cart]
      session[:cart] = {}
    end
  end

  def add
    check_cart
    id = params[:id]
    qty = params[:qty]
    tmp = session[:cart][id].to_i + qty.to_i
    if tmp > 0
      session[:cart][id] = tmp
      msg = 'Ticket was added!'
    else
      msg = 'Ticket was not added!'
    end

    if tmp == 0
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
    if (session[:cart][id])
      session[:cart].delete(id)
    end
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

  def all_cart_items
    check_cart
    return session[:cart]
  end
  helper_method :all_cart_items

  def length
    check_cart
    return session[:cart].length
  end

end
