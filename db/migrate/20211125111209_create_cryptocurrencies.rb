class CreateCryptocurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :cryptocurrencies do |t|
      t.string :symbol
      t.string :name
      t.decimal :last_price

      t.timestamps
    end
  end
end
