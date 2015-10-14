class PlaceOrdersController < ApplicationController
  include MtxUserHelper
  def index

    @daily_menu = MtxWeeklyMenu.find(1)
    @daily_menu_detail = @daily_menu.mtx_weekly_menu_details.all
  end

  def create_order
    @price_text = params[:price_text]
    puts @price_text
    puts params[:total]
    redirect_to place_orders_path
  end
end
