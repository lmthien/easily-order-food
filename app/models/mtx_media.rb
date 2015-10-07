class MtxMedia < ActiveRecord::Base
  self.table_name = 'mtx_media'

  has_and_belongs_to_many :products
end
