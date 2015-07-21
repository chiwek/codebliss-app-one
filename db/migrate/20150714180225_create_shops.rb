class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops  do |t|
      t.string :shopify_domain, :limit => 120, null: false
      t.string :shopify_token, :limit => 120, null: false
      t.timestamps
    end

    add_index :shops, :shopify_domain, unique: true
  end
end
