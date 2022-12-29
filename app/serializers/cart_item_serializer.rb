class CartItemSerializer
  include JSONAPI::Serializer
  attributes :id, :quantity, :cart_id, :product_id
  
  attribute :price_per_unit do |obj|
    obj&.product.price
  end

  attribute :total_price do |obj|
    obj&.product_price
  end

end
