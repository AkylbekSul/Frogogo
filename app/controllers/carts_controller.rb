class CartsController < ApplicationController
  def show
    @cart = @current_cart
  end

  def reset
    @current_cart.cart_items.destroy_all
    @current_cart.update(total_amount: 0)
    redirect_to cart_path, notice: "Cart has been reset."
  end

  def checkout
    @current_cart.cart_items.destroy_all
    @current_cart.update(total_amount: 0)
    session[:cart_id] = nil
    redirect_to root_path, notice: "Thank you for your purchase!"
  end
end
