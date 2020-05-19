class AddViewedToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :viewCount, :integer, :default => 0
  end
end
