class CheckoutController < ApplicationController
  def index
    unless current_user
      redirect_to cart_path, notice: 'You should be logged in!'
      return
    end
    @cartItems = CartController.all_cart_items(session)
    redirect_to home_path if @cartItems.empty?
    @total = CartController.total_price_cart(session)
  end

  def payment
    redirect_to cart_path, notice: 'You should be logged in!' unless current_user
    @cartItems = CartController.all_cart_items(session)
    @total = CartController.total_price_cart(session)

    require 'active_merchant'

    # Use the TrustCommerce test servers
    ActiveMerchant::Billing::Base.mode = :test

    gateway = ActiveMerchant::Billing::BogusGateway.new

    # ActiveMerchant accepts all amounts as Integer values in cents
    amount = (@total * 100).to_i # $10.00

    # The card verification value is also known as CVV2, CVC2, or CID
    credit_card = ActiveMerchant::Billing::CreditCard.new(
      name: params[:'card-holder'],
      number: params[:'card-number'],
      month: params[:MM],
      year: params[:YYYY],
      verification_value: params[:cvc],
      brand: 'bogus'
    )

    # Validating the card automatically detects the card type
    if credit_card.validate.empty?
      # Capture $10 from the credit card
      response = gateway.purchase(amount, credit_card)

      if response.success?
        puts "Successfully charged £#{format('%.2f', amount / 100)} to the credit card #{credit_card.display_number}"
        create_order_from_cart(@cartItems, @total)
        session[:cart] = {}
        m = 'Order was completed successfully! (' + (amount / 100).to_s + '£)'
      else
        raise StandardError, response.message
        m = 'There was an error completing your order!'
      end
    else
      m = 'There was an error verifying your card!'
    end

    redirect_to tickets_path, notice: m
  end

  def create_order_from_cart(cart, total)
    if current_user
      user = current_user.id
      order = Order.create(user: current_user, PriceTotal: total)
      cart.each do |item|
        id = item[0]
        qty = item[1].to_i
        ticket = Ticket.find_by(id: id)
        Purchase.create(order: order, ticket: ticket, qty: qty)
      end
    end
  end
end
