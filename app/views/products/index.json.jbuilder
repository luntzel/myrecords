json.array!(@products) do |product|
  json.extract! product, :id, :band, :album, :price
  json.url product_url(product, format: :json)
end
