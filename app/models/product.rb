class Product
  include Mongoid::Document
  field :band, type: String
  field :album, type: String
  field :price, type: Float
end
