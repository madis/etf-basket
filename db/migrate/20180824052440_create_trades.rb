class CreateTrades < ActiveRecord::Migration[5.2]
  def up
    execute "CREATE TYPE trade_type AS ENUM ('buy', 'sell');"

    create_table :trades do |t|
      t.integer :amount, comment: "Number of shares in trade"
      t.column :type, :trade_type, null: false, comment: "Type of trade: buy or sell"
      t.decimal :price, precision: 10, scale: 2
      t.string :currency
      t.belongs_to :etf_constituent, foreign_key: true
      t.belongs_to :tracking, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :trades
    execute "DROP TYPE trade_type;"
  end
end
