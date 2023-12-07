# Metamorph

Metamorph is a microservice that is responsible for processing transactions sent by the API to the Bitcoin network. It
takes care of re-sending transactions if they are not acknowledged by the network within a certain time period (60
seconds by default).

Metamorph is designed to be horizontally scalable, with each instance operating independently and having its own
transaction store. As a result, the metamorphs do not communicate with each other and remain unaware of each other's existence.


## Transaction lifecycle


