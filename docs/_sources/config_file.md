# Config.yaml

Just one file can be used to configure all the microservices. More precisely, some settings are ignored by some components of ARC and some others are shared or related to. Becouse of that can make sense to try to have a single one coherent with the full design of our deployment.

The most of the facilities provided in the official ARC repo let the user to use a flag to point the directory where the file is although the default predefined locations.


## Some research into config.yaml


The following is an example of config.yaml:


```
logLevel: INFO # mode of logging. Value can be one of DEBUG | INFO | WARN | ERROR
logFormat: tint # format of logging. Value can be one of text | json | tint
profilerAddr: 0.0.0.0:9999 # address to start profiler server on
statisticsServerAddress: 0.0.0.0:9005 # address to start statistics server on
prometheusEndpoint: /metrics # endpoint for prometheus metrics
tracing: true # enable trancing
dataFolder: data # name of data folder
grpcMessageSize: 100000000 # maximum grpc message size
network: regtest # bitcoin network to connect to
ipAddressHint: ^172.28.*

peerRpc: # rpc configuration for bitcoin node
  password: bitcoin
  user: bitcoin
  host: 0.0.0.0 #node1
  port: 18332

peers: # list of bitcoin node peers to connect to
  - host: node1
    port:
      p2p: 18333
      zmq: 28332
  - host: node2
    port:
      p2p: 18333
  - host: node3
    port:
      p2p: 18333

callbacker:
  listenAddr: 0.0.0.0:8021 # address space for callbacker to listen on. Can be for example localhost:8021 or :8021 for listening on all addresses
  dialAddr: arc-callbacker:8021 # address for other services to dial callbacker service
  profilerAddr: localhost:9994
  interval: 1s
  expiryInterval: 1s

metamorph:
  listenAddr: 0.0.0.0:8001 # address space for metamorph to listen on. Can be for example localhost:8001 or :8001 for listening on all addresses
  dialAddr: lb-metamorph:8001 # address for other services to dial metamorph service
  log:
    file: ./data/metamorph.log # location of log file
  db:
    mode: badger # db mode inidicates which db to use. Value can be one of badger | postgres
    cleanData:
      recordRetentionDays: 15
    postgres: # postgres db configuration in case that mode: postgres
      host: localhost
      port: 5432
      name: metamorph
      user: arc
      password: arc
  processorCacheExpiryTime: 24h # time after which processor cache is cleaned
  checkUtxos: false # force check each utxo for validity. If enabled ARC connects to bitcoin node using rpc for each utxo
  statsKeypress: false # enable stats keypress. If enabled pressing any key will print stats to stdout
  profilerAddr: localhost:9992 # address to start profiler server on

blocktx:
  listenAddr: 0.0.0.0:8011 # address space for blocktx to listen on. Can be for example localhost:8011 or :8011 for listening on all addresses
  dialAddr: arc-blocktx:8011 # address for other services to dial blocktx service
  db:
    mode: postgres # db mode inidicates which db to use. Value can be one of sqlite | sqlite_memory | postgres
    postgres: # postgres db configuration in case that mode: postgres
      host: db
      port: 5432
      name: blocktx
      user: arcuser
      password: arcpass
      maxIdleConns: 10 # maximum idle connections
      maxOpenConns: 80 # maximum open connections
      sslMode: disable
  profilerAddr: 0.0.0.0:9993 # address to start profiler server on
  startingBlockHeight: 100 # starting block height for blocktx to start from. blocktx will not request blocks lower than this height

broadcaster:
  apiURL: http://0.0.0.0:9090 # api url for broadcaster to connect to

api:
  address: 0.0.0.0:9090 # address to start api server on
  wocApiKey: "mainnet_XXXXXXXXXXXXXXXXXXXX" # api key for www.whatsonchain.com
  defaultPolicy: # default policy of bitcoin node
    excessiveblocksize: 2000000000
    blockmaxsize: 512000000
    maxtxsizepolicy: 100000000
    maxorphantxsize: 1000000000
    datacarriersize: 4294967295
    maxscriptsizepolicy: 100000000
    maxopsperscriptpolicy: 4294967295
    maxscriptnumlengthpolicy: 10000
    maxpubkeyspermultisigpolicy: 4294967295
    maxtxsigopscountspolicy: 4294967295
    maxstackmemoryusagepolicy: 100000000
    maxstackmemoryusageconsensus: 200000000
    limitancestorcount: 10000
    limitcpfpgroupmemberscount: 25
    maxmempool: 2000000000
    maxmempoolsizedisk: 0
    mempoolmaxpercentcpfp: 10
    acceptnonstdoutputs: true
    datacarrier: true
    minminingtxfee: 1e-8
    maxstdtxvalidationduration: 3
    maxnonstdtxvalidationduration: 1000
    maxtxchainvalidationbudget: 50
    validationclockcpu: true
    minconsolidationfactor: 20
    maxconsolidationinputscriptsize: 150
    minconfconsolidationinput: 6
    minconsolidationinputmaturity: 6
    acceptnonstdconsolidationinput: false


```

We underline:
  * There exists a level 0 section for each ARC main component and also to describe the bitcoin network to be used.
  * The most "listenAddr" (where to listen to) inputs have also a correspondant "dialAddr" input (how other components can reach to connect / dial to this one).
  * Customizing network endpoints is one source of flexibility to modify how the microservices are deployed.
  * Observability with stats, prometheus and jaeger supported by default.
  * Database engine can be shared if needed by blocktx and metamorph by the mean of configure the access.
  * Some common parameters are also needed.
  