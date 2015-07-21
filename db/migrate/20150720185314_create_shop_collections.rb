class CreateShopCollections < ActiveRecord::Migration
  def change
    create_table :shop_collections do |t|
      t.belongs_to :shops, index: true
      t.string :name, :limit => 120, null: false
      t.integer :shop_collection_id, :limit => 16, null: false
      t.datetime :checked_at
      t.timestamps
    end
  end
end
