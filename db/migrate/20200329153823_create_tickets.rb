class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.belongs_to :event, foreign_key: true, null: false
      t.float :price, null: false
      t.string :name, null: false
      t.text :description
      t.integer :quantity

      t.timestamps
    end
  end
end
