json.array!(@mtxProducts) do |mtx_product|
  json.extract! mtx_product, :id, :name, :price, :status, :intro, :description
  json.url mtx_product_url(mtx_product, format: :json)
end
