class AddNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstName, :string, null: false, default: ""
    add_column :users, :lastName, :string, null: false, default: ""
  end
end
