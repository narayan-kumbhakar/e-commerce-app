class CategorySerializer
  include JSONAPI::Serializer
    set_key_transform :camel_lower
    set_type :category
    set_id :id
    attributes :id, :name
end
