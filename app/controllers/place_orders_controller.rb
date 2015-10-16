class PlaceOrdersController < ApplicationController
  include MtxUserHelper
  def index
    @product_items_session = session[:order_items]
    ids = ''

    @product_items_session.each do |items_session|
      ids += items_session + ','
    end

    @product = MtxProduct.where('id in ('+ids[0,ids.length-1]+')')
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

    UserNotifier.send_email(current_user,'Order confirmation','Thank for your order')
    order.save
    session.delete(:order_items)
    redirect_to '/place_orders/order_success'
  end

  def order_success

  end
end
