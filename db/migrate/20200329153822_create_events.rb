class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.string :description
      t.string :location

      t.timestamps
    end
  end
end
