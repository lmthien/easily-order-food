class MtxWeeklyMenu < ActiveRecord::Base
    self.table_name = 'mtx_weekly_menu'

    has_many :mtx_weekly_menu_details, :class_name => 'MtxWeeklyMenuDetail', :foreign_key => :weekly_menu_id, :dependent => :destroy
end
