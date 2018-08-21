class CreateEtfs < ActiveRecord::Migration[5.2]
  def change
    create_table :etfs do |t|
      t.string :name
      t.string :symbol, index: {unique: true}

      t.timestamps
    end
  end
end
