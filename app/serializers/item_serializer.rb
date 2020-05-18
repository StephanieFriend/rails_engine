class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :merchant_id
end
