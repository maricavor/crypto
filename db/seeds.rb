Cryptocurrency.create(symbol: 'BTC', name: 'Bitcoin', multisig_factor: 2, 
                      api_url: 'https://api.blockchain.info/mempool/fees', 
                      cost_attribute: 'priority')
Cryptocurrency.create(symbol: 'ETH', name: 'Ethereum', multisig_factor: 20, 
                      api_url: 'https://api.etherscan.io/api?module=gastracker&action=gasoracle&apikey=YourApiKeyToken', 
                      cost_attribute: 'FastGasPrice')
Cryptocurrency.create(symbol: 'BNB', name: 'Binance Coin', multisig_factor: 20, 
                      api_url: 'https://api.bscscan.com/api?module=gastracker&action=gasoracle&apikey=YourApiKeyToken', 
                      cost_attribute: 'FastGasPrice')
Cryptocurrency.create(symbol: 'BSV', name: 'Bitcoin SV', multisig_factor: nil, 
                      api_url: 'https://mapi.taal.com/mapi/feeQuote', 
                      cost_attribute: 'standard')