class HomeController < ApplicationController
  include MtxUserHelper
  helper_method :add_item

  def permission_message

  end
  
  def index
    @dayOfWeekList = {1 => "mon",
                      2 => "tue",
                      3 => "wed",
                      4 => "thu",
                      5 => "fri",
                      6 => "sat",
                      0 => "sun"
    }
    @today = @dayOfWeekList[Date.today.wday]
    @weeklyMenuToday = MtxWeeklyMenu.find_by(["day_key = ?", @today])
    @weeklyMenuDetailToday = nil
    if (@weeklyMenuToday != nil)
      @weeklyMenuDetailToday = MtxWeeklyMenuDetail.where("weekly_menu_id = ?", @weeklyMenuToday.id)
    end

    if session[:order_items].nil?
      session[:order_items] ||= []
      @cart = []
    else
      @cart = session[:order_items]
    end

    @customer = false
    if (current_user != nil && current_user.user_type != 1)
      @customer = true
    end
  end

  def add_item
    if !session[:order_items].include? params[:product_id]
      session[:order_items].push(params[:product_id])
    end
    respond_to do |format|
      format.json { render json: session[:order_items] }
    end
  end
end
