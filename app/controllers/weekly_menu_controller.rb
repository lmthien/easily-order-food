class WeeklyMenuController < ApplicationController
  layout "admin"
  include MtxUserHelper

  def manage
    #get product of weekly menu
    @dayOfWeek = params[:dayOfWeek]
    @productOfWeekDay = MtxWeeklyMenu.find_by(["day_key = ?", @dayOfWeek])
    # config.logger = Logger.new(STDOUT)
    # logger.debug "1111111111111111"
    # logger.debug {@productOfWeekDay.mtx_weekly_menu_details}
    # exit

    #get all product
    @productList = MtxProduct.all

    # config.logger = Logger.new(STDOUT)
    # logger.debug "1111111111111111"
    # logger.debug {@dayOfWeek}
    # exit

    #data source for weekday dropdown list
    @ds4WeekDaySelect = {
        :mon => "Monday",
        :tue => "Tuesday",
        :wed => "Wednesday",
        :thu => "Thursday",
        :fri => "Friday",
        :sat => "Satusday",
        :sun => "Sunday"
    }
  end

  def update
    @ds4WeekDaySelect = {
      'mon' => "Monday",
      'tue' => "Tuesday",
      'wed' => "Wednesday",
      'thu' => "Thursday",
      'fri' => "Friday",
      'sat' => "Satusday",
      'sun' => "Sunday"
    }

    @dayOfWeek = params[:weekday]
    @productIds = params[:ids]

    @weekDay = MtxWeeklyMenu.find_or_create_by(day_key: @dayOfWeek) do |weeklyMenu|
      weeklyMenu.day_title = @ds4WeekDaySelect[@dayOfWeek]
    end

    unless @productIds.nil?
      @products_of_weekly_menu = []
      @productIds.each { |id| @products_of_weekly_menu.push({:product_id => id, :weekly_menu_id => @weekDay.id})}
      MtxWeeklyMenuDetail.create(@products_of_weekly_menu)
    end

    redirect_to weekly_menu_manage_path(:dayOfWeek => @dayOfWeek)
  end
end
