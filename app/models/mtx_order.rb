class MtxOrder < ActiveRecord::Base
    self.table_name = 'mtx_order'

    has_many :mtx_order_details, :class_name => 'MtxOrderDetail'
end
