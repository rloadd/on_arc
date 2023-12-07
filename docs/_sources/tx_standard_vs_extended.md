
# Transaction formats

ARC has been designed to save request to the Bitcoin network. For this reason it is expected that transactions come in an extended format. Transactions in standard format requires a pretreatment to convert each tx into one in extended format to pass through the ARC pipeline.

That pretreatment detracts from the expected efficiency of the process because it requires extra requests to the Bitcoin network. Therefore, it is expected that the trend will be to use the extended format, which may be the only one supported in the future.

Comparison beteen extended and standard format is the following (can be found in detail in BIP-239 / [BRC-30](https://github.com/bitcoin-sv/BRCs/blob/master/transactions/0030.md)).



## Standard Format 

The input structure is the only additional thing that is changed in the Extended Format. The current input structure looks like this:

| Field                     | Description                                                                                 | Size                          |
|---------------------------|---------------------------------------------------------------------------------------------|-------------------------------|
| Previous Transaction hash | TXID of the transaction the output was created in                                           | 32 bytes                      |
| Previous Txout-index      | Index of the output (Non negative integer)                                                  | 4 bytes                       |
| Txin-script length        | Non negative integer VI = VarInt                                                            | 1 - 9 bytes                   |
| Txin-script / scriptSig   | Script                                                                                      | <in-script length>-many bytes | 
| Sequence_no               | Used to iterate inputs inside a payment channel. Input is final when nSequence = 0xFFFFFFFF | 4 bytes                       |


## Extended format

In the Extended Format, we extend the input structure to include the previous locking script and satoshi outputs. Novelties are in bold style.

| Field                          | Description                                                                                 | Size                            |
|--------------------------------|---------------------------------------------------------------------------------------------|---------------------------------|
| Previous Transaction hash      | TXID of the transaction the output was created in                                           | 32 bytes                        |
| Previous Txout-index           | Index of the output (Non negative integer)                                                  | 4 bytes                         |
| Txin-script length             | Non negative integer VI = VarInt                                                            | 1 - 9 bytes                     |
| Txin-script / scriptSig        | Script                                                                                      | <in-script length>-many bytes   | 
| Sequence_no                    | Used to iterate inputs inside a payment channel. Input is final when nSequence = 0xFFFFFFFF | 4 bytes                         |
| **Previous TX satoshi output** | **Output value in satoshis of previous input**                                              | **8 bytes**                     |
| **Previous TX script length**  | **Non negative integer VI = VarInt**                                                        | **1 - 9 bytes**                 |
| **Previous TX locking script** | **Script**                                                                                  | **\<script length>-many bytes** | 

## Backward compatibility

The Extended Format is not backwards compatible, but has been designed in such a way that existing software should not read a transaction in Extend Format as a valid (partial) transaction. The Extended Format header (0000000000EF) will be read as an empty transaction with a future nLock time in a library that does not support the Extended Format.




