class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.string :currency
      t.belongs_to :etf_constituent, foreign_key: true, on_delete: :cascade, null: false

      t.timestamps
    end
  end
end
