class AddIsBusinessToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :isBusiness, :boolean, null: false, :default => false
  end
end
