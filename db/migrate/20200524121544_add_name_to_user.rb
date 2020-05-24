class AddNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstName, :String, null: false, default: ""
    add_column :users, :lastName, :String, null: false, default: ""
  end
end
