class CreateEtfConstituents < ActiveRecord::Migration[5.2]
  def change
    create_table :etf_constituents do |t|
      t.string :name
      t.string :symbol, index: {unique: true}
      t.decimal :weight, precision: 11, scale: 8 # Support 100.00000000
      t.belongs_to :etf

      t.timestamps
    end
  end
end
