class MtxUser < ActiveRecord::Base
    self.table_name = 'mtx_user'

    self.inheritance_column = :ruby_type
    has_many :mtx_order, :class_name => 'MtxOrder'
end
