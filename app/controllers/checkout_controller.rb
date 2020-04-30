class CheckoutController < ApplicationController
  def index
    @cartItems = CartController.all_cart_items(session)
    if @cartItems.length == 0
      redirect_to home_path
    end
    @total = CartController.total_price_cart(session)
  end
end
