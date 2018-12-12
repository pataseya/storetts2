class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.integer :product_id
      t.integer :quantity
      t.decimal :line_item_toal
      t.integer :order_id

      t.timestamps
    end
  end
end
