# ARC
> Transaction processor for Bitcoin


**ARC** is a multi-layer transaction processor for Bitcoin that dramatically increases the performance of Bitcoin nodes processing  transactions. ARC keeps track of the lifecycle of a transaction as it is processed by the Bitcoin network.

Unlike other transaction processors, ARC broadcasts all transactions on the p2p network, and does not rely on the rpc
interface of a single Bitcoin node. This makes it possible for ARC to connect and broadcast to any number of nodes, as many as are desired. In the future, ARC will be also able to send transactions using ipv6 multicast, which will make it
possible to connect to a large number of nodes without incurring large bandwidth costs.

The ARC design decouples the core functions of a transaction processor and encapsulates them as microservices with the ability to scale horizontally adaptively. Interaction between microservices is decoupled using asynchronous messaging where possible.

![Architecture](arc_january_2023.png)

ARC mainly consists of four microservices: [API](main_api), [Metamorph](main_metamorph), [BlockTx](main_blocktx) and [Callbacker](main_callbacker), which are all described in this documentation.


