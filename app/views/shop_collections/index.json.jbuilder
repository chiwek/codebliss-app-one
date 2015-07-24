json.array!(@shop_collections) do |shop_collection|
  json.extract! shop_collection, :id, :name, :shop_collection_id, :autofill, :sort_field, :sort_order, :instock_only, :checked_at
  json.url shop_collection_url(shop_collection, format: :json)
end
