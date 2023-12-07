# API

API is the REST API microservice for interacting with ARC. See the [API documentation](/arc/api.html) for more information.

The API takes care of authentication, validation, and sending transactions to Metamorph.  The API talks to one or more Metamorph instances using client-based, round robin load balancing.


## Authorization


## Validation

The API is the first component of ARC and therefore the one that by design derives a benefit for ARC performing a preliminar validation of transactions thanks to the use of the extended transaction format [discussed below](tx_extended). 

However, sending transactions in classic format is supported through the ARC API.


When possible, the API is responsible for rejecting transactions that would be unacceptable to the Bitcoin network. By using the extended transaction format it is possible to perform detection of incorrect transactions and reject them without false positives.


## Header options

ARC processing supports several modes customer application can use. This modes are set using HTTP headers in any transaction/s sending. 

Following table shows available header options.

|  Header | Value  |
|---|---|
|  X-CallbackUrl | true | false  | 
|  X-SkipFeeValidation | true | false  | 
|  X-SkipScriptValidation | true | false  | 
|  X-SkipTxValidation | true | false  | 
|  X-CallbackToken | true | false  | 
|  X-MerkleProof | true | false  | 
|  X-WaitForStatus | true | false  | 



This curl example show how can be set the callback url ARC must notify events back to the client app.

```
curl 
```