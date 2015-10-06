class MtxProductLanguage < ActiveRecord::Base
    self.table_name = 'mtx_product_language'


    belongs_to :mtx_product, :class_name => 'MtxProduct', :foreign_key => :product_id
end
