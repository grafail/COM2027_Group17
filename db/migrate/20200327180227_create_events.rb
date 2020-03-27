class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :SellerID
      t.string :Name
      t.string :Address
      t.string :Twitter
      t.boolean :IsBusiness

      t.timestamps
    end
  end
end
