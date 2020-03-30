class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.belongs_to :user, foreign_key: true, null: false, unique: true
      t.string :name, null: false
      t.text :description
      t.text :location, null: false

      t.timestamps
    end
  end
end
