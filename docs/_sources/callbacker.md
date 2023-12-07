# Callbacker 

Callbacker is a very simple microservice that is responsible for sending callbacks to clients when a transaction has been accepted by the Bitcoin network. To register a callback, the client must add the `X-CallbackUrl` header to the request. The callbacker will then send a POST request to the URL specified in the header, with the transaction ID in the body. 


<!-- See the [API documentation](/arc/api.html) for more information. -->

