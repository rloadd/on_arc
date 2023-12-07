(lifecycle)=

# Transaction lifecycle

The ARC architecture has been designed to assist in the management of the transaction lifecycle, enabling better tracking of the status of each transaction, reissuing transactions until they are seen by the network and notifying the issuer of relevant status changes. This ARC feature allows clients and bitcoin wallets to be lighter and more efficient in their mission.


![Transaction lifecycle.](transaction_lifecycle.png)


ARC is a transaction processor for Bitcoin that keeps track of the life cycle of a transaction as it is processed by
the Bitcoin network. Next to the mining status of a transaction, ARC also keeps track of the various states that a
transaction can be in, such as `ANNOUNCED_TO_NETWORK`, `SEEN_IN_ORPHAN_MEMPOOL`, `SENT_TO_NETWORK`, `SEEN_ON_NETWORK`, `MINED`, `REJECTED`, etc.

If a transaction is not `SEEN_ON_NETWORK` within a certain time period (60 seconds by default), ARC will re-send the
transaction to the Bitcoin network. ARC also monitors the Bitcoin network for transaction and block messages, and
will notify the client when a transaction has been mined, or rejected.

Unlike other transaction processors, ARC broadcasts all transactions on the p2p network, and does not rely on the rpc
interface of a Bitcoin node. This makes it possible for ARC to connect and broadcast to any number of nodes, as many
as are desired. In the future, ARC will be also able to send transactions using ipv6 multicast, which will make it
possible to connect to a large number of nodes without incurring large bandwidth costs.



All the microservices are designed to be horizontally scalable, and can be deployed on a single machine or on multiple machines. Each one has been programmed with a store interface and various databases can be used to store data. The default store is sqlite3, but any database that implements the store interface can be used.


