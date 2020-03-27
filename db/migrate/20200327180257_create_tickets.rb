class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.integer :EventID
      t.float :Price
      t.string :Name
      t.string :Description

      t.timestamps
    end
  end
end
