class UpdateCryptocurrencies < ActiveRecord::Migration[6.1]
  def change
    add_column :cryptocurrencies, :multisig_factor, :decimal, default: nil
    add_column :cryptocurrencies, :api_url, :string
    add_column :cryptocurrencies, :cost_attribute, :string
    remove_column :cryptocurrencies, :last_price
  end
end
