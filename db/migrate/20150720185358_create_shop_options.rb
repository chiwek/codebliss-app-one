class CreateShopOptions < ActiveRecord::Migration
  def change
    create_table :shop_options do |t|
      t.belongs_to :shops, index: true
    end
  end
end
