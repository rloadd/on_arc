
# Extended format efficiency

For optimal performance, ARC uses a custom format for transactions. This format is called the extended format, and is a superset of the raw transaction format. The extended format includes the satoshis and scriptPubKey for each input, which makes it possible for ARC to validate the transaction without having to download the parent transactions. In most cases the sender already has all the information from the parent transaction, as this is needed to sign the transaction.

The only check that cannot be done on a transaction in the extended format is the check for double spends. This can only be done by downloading the parent transactions, or by querying a utxo store. A robust utxo store is still in development and will be added to ARC when it is ready. At this moment, the utxo check is performed in the Bitcoin node when a transaction is sent to the network.

With the successful adoption of Bitcoin ARC, this format shou   ld establish itself as the new standard of interchange between wallets and non-mining nodes on the network.

The extended format has been described in detail in BIP-239 / [BRC-30](https://github.com/bitcoin-sv/BRCs/blob/master/transactions/0030.md).


The following diagrams show the difference between validating a transaction in the standard and extended format:



## Standard format treatment impact

For this reason it is expected that transactions come in an extended format. Transactions in standard format requires a pretreatment to convert each tx into one in extended format to pass through the ARC pipeline.

That pretreatment detracts from the expected efficiency of the process because it requires extra requests to the Bitcoin network. Therefore, it is expected that the trend will be to use the extended format, which may be the only one supported in the future.

![Standard transaction flow.](uml_flow_tx_standard.png)


## Extended format flow

In contrast, the extended format allows the API to perform a preliminary validation and rule out malformed transactions by reviewing the transaction data provided in the extended fashion. Obviously, double spending (for example) cannot be checked without an updated utxo set and it is assumed that the API does not have this data. Therefore, the "validator" subfunction within the API filters as much as it can to reduce spurious transactions passing through the pipeline but leaves others for the bitcoin nodes themselves.

![Extended transaction format. Typical flow.](uml_transaction_flow.png)

