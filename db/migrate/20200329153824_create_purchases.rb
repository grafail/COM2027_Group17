class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :ticket, foreign_key: true
      t.string :comments
      t.float :PriceTotal

      t.timestamps
    end
  end
end
