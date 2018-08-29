class ChangeEtfsPortfoliosToTrackings < ActiveRecord::Migration[5.2]
  def change
    rename_table :etfs_portfolios, :trackings
  end
end
