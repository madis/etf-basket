class AddPrimaryKeyToTrackings < ActiveRecord::Migration[5.2]
  def change
    add_column :trackings, :id, :primary_key
    add_index :trackings, [:portfolio_id, :etf_id], unique: true
  end
end
