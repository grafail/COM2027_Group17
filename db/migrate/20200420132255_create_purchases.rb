class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.belongs_to :ticket, foreign_key: true, null: false
      t.belongs_to :order, foreign_key: true, null: false
      t.integer :qty, null: false

      t.timestamps
    end
  end
end
