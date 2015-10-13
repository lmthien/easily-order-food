class HomeController < ApplicationController
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
    @weeklyMenuDetailToday = MtxWeeklyMenuDetail.where("weekly_menu_id = ?", @weeklyMenuToday.id)
  end
end
