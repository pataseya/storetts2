class RenameColumnLineItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :line_items, :line_item_toal, :line_item_total
  end
end
