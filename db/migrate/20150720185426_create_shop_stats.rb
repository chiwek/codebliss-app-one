class CreateShopStats < ActiveRecord::Migration
  def change
    create_table :shop_stats do |t|
      t.belongs_to :shops, index: true
      t.integer :execution_time, null: false
      t.string :action_call, null: false
      t.text :log, null: false      
      t.timestamps
    end
  end
end
