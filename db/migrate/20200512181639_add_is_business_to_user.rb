class AddIsBusinessToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :isBusiness, :boolean
  end
end
