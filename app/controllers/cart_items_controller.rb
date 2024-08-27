class CartItemsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    @cart_item = @current_cart.cart_items.find_or_initialize_by(product: product)
    if @cart_item.new_record?
      @cart_item.quantity = 1
    else
      @cart_item.quantity += 1
    end
    @cart_item.save
    @current_cart.calculate_total
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Product added to cart." }
      format.turbo_stream { render turbo_stream: turbo_stream.update("cart_items", partial: "cart_items", locals: { cart: @current_cart}) }
    end
  end

  def decrement
    @cart_item = @current_cart.cart_items.find(params[:id])
    if @cart_item.quantity == 1
      @cart_item_id = @cart_item.id
      @cart_item.destroy
    else
      @cart_item.quantity -= 1
      @cart_item.save
    end
    @current_cart.calculate_total
    respond_to do |format|
      format.html { redirect_to cart_path, notice: "Quantity updated" }
      format.turbo_stream { render "update_count", locals: { cart_item: @cart_item } }
    end
  end

  def increment
    @cart_item = @current_cart.cart_items.find(params[:id])
    @cart_item.quantity += 1
    @cart_item.save
    @current_cart.calculate_total
    respond_to do |format|
      format.html { redirect_to cart_path, notice: "Quantity updated" }
      format.turbo_stream { render "update_count", locals: { cart_item: @cart_item } }
    end
  end

  def destroy
    @cart_item = @current_cart.cart_items.find(params[:id])
    @cart_item.destroy
    @current_cart.calculate_total
    respond_to do |format|
      format.html { redirect_to cart_path, notice: "Product removed from cart." }
      format.turbo_stream { render "update_count", locals: { cart_item: @cart_item } }
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
