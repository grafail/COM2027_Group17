class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.belongs_to :ticket, foreign_key: true, null:false
      t.belongs_to :cart, foreign_key: true, null:false

      t.timestamps
    end
  end
end
