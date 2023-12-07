# Command line 

As well as a microservices, it makes sense to interact with ARC using command line utilities. Currently, that is possible since you have a clone of the repo and all the go environment ready. 

"cmd" utilities are useful for doing speficic and isolated operations with ARC.


## Broadcaster

It lets send transactions to the bitcoin network through ARC. It is mainly used for testing porpouses as it implies some fee. Broadcaster can perform batch transactions to test an ARC deployment. 

NOTE: You have to clone the official ARC github repo (https://github.com/bitcoin-sv/arc) and put your own config.yml (in https://github.com/rloadd/on_arc we provide ours for testing) in the root of your copy to get the broadcaster working properly.

```
go run cmd/broadcaster/main.go -api=true -consolidate \
        -authorization=mainnet_XXX -batch=100 1000

```


NOTE2: broadcaster in "cmd" fashion doesn't support option "-config". Hopefully, in the future "cmd" commands will support more flags. I've done by my own to launch the same more confortable. 

```
go run cmd/broadcaster/main.go -config=../arc_cover/decoupled/ \
        -api=true -consolidate -authorization=mainnet_XXX   \
        -batch=100 1000

```

What you get is a log with traces of the tx batches, and a final report of the final status for them and a final elapsed time spent in this operation. Very useful mainly to stress an ARC deployment.

