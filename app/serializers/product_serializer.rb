class ProductSerializer
  include JSONAPI::Serializer
  attributes :name, :manufacturer, :prod_desc, :prod_feature, :price

  attribute :category_name do |obj|
    obj&.category.name
  end

  belongs_to :category

end
