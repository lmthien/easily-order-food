class MtxProductLanguage < ActiveRecord::Base
    self.table_name = 'mtx_product_language'
    validates_presence_of :name

    belongs_to :mtx_product, :class_name => 'MtxProduct', :foreign_key => :product_id
end
