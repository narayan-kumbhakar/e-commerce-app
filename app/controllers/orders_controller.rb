class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end
 
  def create
    @current_cart = Cart.where(user_id: params[:user_id]).first
    if @current_cart.cart_items.empty?
        render json: {message: "you cart is empty"}
    else
        @order = Order.new(order_params)
        @order.update(user_id: params[:user_id])
        add_cart_items_to_order
        @order.save!
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
  end

  def ordered_products
    @order = Order.where(user_id: params[:user_id])
    @products = []
    @order.each do |order|
        order.cart_items.where.not(order_id: nil).each do |cart_item|
            @products << cart_item.product
        end
    end  
    render json: @products
  end

  private

  def add_cart_items_to_order
    @current_cart.cart_items.each do |item|
      item.cart_id = nil
      item.order_id = @order.id
      item.save
      @order.cart_items << item
    end
  end

  def order_params
    params.permit(:user_id, :status, :description)
  end
end
