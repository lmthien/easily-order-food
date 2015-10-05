class MtxMedia < ActiveRecord::Base
  self.table_name = 'mtx_media'

  has_many_belongs_to_many :products
end
