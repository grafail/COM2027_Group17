class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.belongs_to :event, foreign_key: true
      t.float :price
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
