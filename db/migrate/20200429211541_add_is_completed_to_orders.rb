class AddIsCompletedToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :isComplete, :boolean, :default => false
  end
end
