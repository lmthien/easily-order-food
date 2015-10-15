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
    @ds4WeekDaySelect = {:mon => "Monday",
                         :tue => "Tuesday",
                         :wed => "Wednesday",
                         :thu => "Thursday",
                         :fri => "Friday",
                         :sat => "Satusday",
                         :sun => "Sunday"
    }
  end

  def update
    @ds4WeekDaySelect = {:mon => "Monday",
                         :tue => "Tuesday",
                         :wed => "Wednesday",
                         :thu => "Thursday",
                         :fri => "Friday",
                         :sat => "Satusday",
                         :sun => "Sunday"
    }

    @dayOfWeek = params[:weekday]
    @productIds = params[:ids]

    @weekDay = MtxWeeklyMenu.find_by(["day_key = ?", @dayOfWeek])
    if !@weekDay.nil?
        @weekDay.mtx_weekly_menu_details.each {
            |p| p.destroy
        }
    else
      @weekDay = MtxWeeklyMenu.create(:day_key => @dayOfWeek, :day_title => @ds4WeekDaySelect[:@dayOfWeek])
    end
    if @productIds.any?
      @productIds.each {
          |id| MtxWeeklyMenuDetail.create(:product_id => id, :weekly_menu_id => @weekDay.id)
      }
    end

    redirect_to weekly_menu_manage_path(:dayOfWeek => @dayOfWeek)
  end
end
