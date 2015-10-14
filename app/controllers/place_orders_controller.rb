class PlaceOrdersController < ApplicationController
  include MtxUserHelper
  def index
    @daily_menu = MtxWeeklyMenu.find(1)
    @daily_menu_detail = @daily_menu.mtx_weekly_menu_details.all
  end

  def create_order
    # Create order
    order = MtxOrder.new
    order.customer_id = current_user.id
    order.phone = 'phone'
    order.email = 'email address'
    order.discount = 0
    order.status = 1
    order.shipping_address = 'shipping_address'
    order.note = 'note'
    order.total = params[:total_order].to_i

    # Create order detail
    params[:product].each do |key,value|
      @product_id = key.split('_')[0]
      @product_price = key.split('_')[1]
      puts "Product id #{@product_id} with price #{@product_price} have order #{value} quantity"
      orderDetail = MtxOrderDetail.new
      orderDetail.product_id = @product_id
      orderDetail.quantity = value
      orderDetail.price = @product_price
      order.mtx_order_details << orderDetail
    end

    order.save
    redirect_to place_orders_path
  end
end
