class MtxLanguage < ActiveRecord::Base
    self.table_name = 'mtx_language'


    has_many :mtx_product_languages, :class_name => 'MtxProductLanguage'
end
