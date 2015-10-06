class MtxOrderDetail < ActiveRecord::Base
    self.table_name = 'mtx_order_detail'

    belongs_to :mtx_order, :class_name => 'MtxOrder', :foreign_key => :order_id
    belongs_to :mtx_product, :class_name => 'MtxProduct', :foreign_key => :product_id
end
