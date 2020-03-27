class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.integer :TicketID
      t.string :Comments
      t.float :PriceTotal
      t.integer :PurchaserID

      t.timestamps
    end
  end
end
