class MtxOrder < ActiveRecord::Base



    has_many :mtx_order_details, :class_name => 'MtxOrderDetail'
end
