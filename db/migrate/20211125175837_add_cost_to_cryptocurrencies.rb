class AddCostToCryptocurrencies < ActiveRecord::Migration[6.1]
  def change
    add_column :cryptocurrencies, :last_transaction_cost, :decimal, :precision => 8, :scale => 2, :default=>0
  end
end
