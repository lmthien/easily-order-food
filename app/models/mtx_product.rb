class MtxProduct < ActiveRecord::Base
    self.table_name = 'mtx_product'

    has_many :mtx_order_details, :class_name => 'MtxOrderDetail'
    has_many :mtx_product_languages, :class_name => 'MtxProductLanguage', :foreign_key => :product_id
    has_many :mtx_weekly_menu_details, :class_name => 'MtxWeeklyMenuDetail'
    # has_many_belongs_to_many :medias
end
