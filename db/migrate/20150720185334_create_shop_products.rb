class CreateShopProducts < ActiveRecord::Migration
  def change
    create_table :shop_products do |t|
      t.belongs_to :shop_collections, index: true
      t.string :name, :limit => 120, null: false
      t.integer :shop_product_id, :limit => 11, null: false
      t.datetime :checked_at
      t.datetime :published_at
      t.integer :order_num
      t.timestamps
    end
  end
end
