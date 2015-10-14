class MtxOrder < ActiveRecord::Base
    self.table_name = 'mtx_orders'

    has_many :mtx_order_details, :class_name => 'MtxOrderDetail', :foreign_key => :order_id
    belongs_to :mtx_user, :class_name => 'MtxUser', :foreign_key => :customer_id
    scope :ordered_by_username, -> { joins(:mtx_user).order('mtx_user.username') }
end
