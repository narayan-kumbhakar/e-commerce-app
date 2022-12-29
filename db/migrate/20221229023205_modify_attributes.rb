class ModifyAttributes < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :order_id, :integer
    remove_column :cart_items, :price, :float
  end
end
