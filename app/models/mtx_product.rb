class MtxProduct < ActiveRecord::Base
    self.table_name = 'mtx_product'

    has_many :mtx_order_details, :class_name => 'MtxOrderDetail'
    has_many :mtx_product_languages, :class_name => 'MtxProductLanguage', :foreign_key => :product_id
    has_many :mtx_weekly_menu_details, :class_name => 'MtxWeeklyMenuDetail'
    has_and_belongs_to_many :medias

    accepts_nested_attributes_for :mtx_product_languages
end
