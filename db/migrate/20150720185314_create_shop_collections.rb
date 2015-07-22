class CreateShopCollections < ActiveRecord::Migration
  def change
    create_table :shop_collections do |t|
      t.belongs_to :shops, index: true
      t.string :name, :limit => 120, null: false
      t.integer :shop_collection_id, :limit => 11, null: false
      t.boolean :autofill, null: false
      t.string :sort_field, null: false
      t.string :sort_order, null: false
      t.boolean :instock_only, null: false
      t.datetime :checked_at
      t.timestamps
    end
  end
end
