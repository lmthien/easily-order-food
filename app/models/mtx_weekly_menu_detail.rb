class MtxWeeklyMenuDetail < ActiveRecord::Base
    self.table_name = 'mtx_weekly_menu_detail'

    belongs_to :mtx_weekly_menu, :class_name => 'MtxWeeklyMenu', :foreign_key => :weekly_menu_id
    belongs_to :mtx_product, :class_name => 'MtxProduct', :foreign_key => :product_id
    belongs_to :mtx_product_language, :class_name => 'MtxProductLanguage', :foreign_key => :product_id
end
