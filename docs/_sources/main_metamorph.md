# Metamorph

Metamorph is the microservice responsible for processing transactions sent by the API to the Bitcoin network. It
takes care of re-sending transactions if they are not acknowledged by the network within a certain time period (60
seconds by default).

Metamorph is designed to be horizontally scalable, with each instance operating independently and having its own
transaction store. As a result, the metamorphs do not communicate with each other and remain unaware of each other's existence.



## Metamorph stores

As an independent service, metamorph can have its own database separate from the rest of the ARC services. Metamorph store has been implemented for multiple databases, depending on your needs. In high-volume environments, you may want to use a database that is optimized for high throughput, such as [Badger](https://dgraph.io/docs/badger).

The following databases have been implemented:

* Sqlite3 (`sqlite` or `sqlite_memory` for in-memory)
* Postgres (`postgres`)
* Badger (`badger`)
* BadgerHold (`badgerhold`)

You can select the store to use by setting the `metamorph.db.mode` in the settings file or adding `metamorph.db.mode` as
an environment variable.

## Metamorph transaction statuses

Metamorph keeps track of the lifecycle of a transaction, and assigns it a status. The following statuses are
available:

| Code | Status                 | Description                                                                                                                                                                                              |
|-----|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 0   | `UNKNOWN`              | The transaction has been sent to metamorph, but no processing has taken place. This should never be the case, unless something goes wrong.                                                               |
| 1   | `QUEUED`               | The transaction has been queued for processing.                                                                                                                                                          |
| 2   | `RECEIVED`             | The transaction has been properly received by the metamorph processor.                                                                                                                                   |
| 3   | `STORED`               | The transaction has been stored in the metamorph store. This should ensure the transaction will be processed and retried if not picked up immediately by a mining node.                                  |
| 4   | `ANNOUNCED_TO_NETWORK` | The transaction has been announced (INV message) to the Bitcoin network.                                                                                                                                 |
| 5   | `REQUESTED_BY_NETWORK` | The transaction has been requested from metamorph by a Bitcoin node.                                                                                                                                     |
| 6   | `SENT_TO_NETWORK`      | The transaction has been sent to at least 1 Bitcoin node.                                                                                                                                                |
| 7   | `ACCEPTED_BY_NETWORK`  | The transaction has been accepted by a connected Bitcoin node on the ZMQ interface. If metamorph is not connected to ZMQ, this status will never by set.                                                 |
| 8   | `SEEN_ON_NETWORK`      | The transaction has been seen on the Bitcoin network and propagated to other nodes. This status is set when metamorph receives an INV message for the transaction from another node than it was sent to. |
| 9   | `MINED`                | The transaction has been mined into a block by a mining node.                                                                                                                                            |
| 10  | `SEEN_IN_ORPHAN_MEMPOOL`             | The transaction has been sent to at least 1 Bitcoin node but parent transaction was not found. |
| 108 | `CONFIRMED`            | The transaction is marked as confirmed when it is in a block with 100 blocks built on top of that block.                                                                                                 |
| 109 | `REJECTED`             | The transaction has been rejected by the Bitcoin network.                                                                                                                                                |

This status is returned in the `txStatus` field whenever the transaction is queried.


A [transaction lifecycle graph](tx_lifecycle) is available in this documentation .


## Connection to the Bitcoin netowrk

Metamorph can connect to multiple Bitcoin nodes, and will use a subset of the nodes to send transactions to. The other
nodes will be used to listen for transaction **INV** message, which will trigger the SEEN_ON_NETWORK status of a transaction.

The Bitcoin nodes can be configured in the settings file.

## Whitelisting

Metamorph is talking to the Bitcoin nodes over the p2p network. If metamorph sends invalid transactions to the
Bitcoin node, it will be **banned** by that node. Either make sure not to send invalid or double spend transactions through metamorph, or make sure that all metamorph servers are **whitelisted** on the Bitcoin nodes they are connecting to.

<!-- ## Hands on lab

### Command line

You can run metamorph like this:

```shell
go run cmd/metamorph/main.go
```

or using the generic `main.go`:

```shell
go run main.go -metamorph=true
```

The only difference between the two is that the generic `main.go` starts the Go profiler, while the specific
`cmd/metamorph/main.go` command does not.

### Using docker


In this repository you can find Dockerfile and docker-compose to run metamorph and it needs as docker containers. -->



