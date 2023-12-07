

# Important

THIS IS NOT AUTHORITATIVE DOCUMENTATION ON ARC PROJECT OF Bitcoin SV.
The authoritative documentation can be found at:

  * https://bitcoin-sv.github.io/arc/
  * https://github.com/bitcoin-sv/arc
  * https://www.bsvblockchain.org/features/arc
  

This repo contains tips and hints to start up and test the ARC infrastructure while developers are building it. Following recipes built artifacts strictly based on the content of the official repo https://bitcoin-sv.github.io/arc/ and isolated in docker containers. PLEASE, TAKE CARE AS THE CODE OF ARC IS BEING UPDATED IN REAL TIME AND COULD BE INMATURE IN SOME PARTS.


## Mission: improve documentation

First, I am doing this work from my own understanding by reading the source code and jumping around the published ARC documentation. The intent is to summarize, but ARC I don't know if it's going to be a short or long summary. ARC is a large project with an ambitious design for scaling based on microservices, intended for the cloud, benefiting from other mature software projects for bitcoin, with test integration in the continuous deployment cycle, with several dimensions of observability, etc.. 

Second, the ARC is being deployed right now (December 2023). Some details or malfunctions could change as they are told, so some claims or the depth of claims should slowly be filled in.

Lastly, this repo is a best effort project. Sorry for the imprecissions, inconveniences if some misunderstanding occurs and if my pace of my update is sloooooow. Official sources are listed above.


At https://rloadd.github.io/on_arc/ (this repo) I am unifying ARC documentation and extending some parts that can accelerate the undertanding for those that want to deploy it own instance of ARC. Following sections of this README are a shortcut to run ARC for test porpouses and will be finally also included in github pages.


## Testing

 Why do the tests appear first ? That's where I would start. Surely to create it you have to see it started, recognize the ARC components and see where the transactions evolve. By taking the tests provided in the official repo and stitching them with other ideas we can test it at home.

## Regular tests

The core tests are the ones included in the main repo or ARC. Docker will build the image by cloning the repo and preparing the executable at once. Nothing has to be cloned, installed or compiled separately, except, obviously, the Docker environment and tools.

This directory provides a config.yaml and the rest of the config files aligned with the docker-compose files provided.


### Simplest infrastructure

Each service in its own separated container. Just one container by service.

```
docker-compose -f docker-compose.yml up
```

```
$ docker ps
CONTAINER ID   IMAGE                         COMMAND                  CREATED          STATUS                    PORTS                                                                                               NAMES
ee1e00cc4bde   arc-image:latest              "/service/arc -callb…"   21 minutes ago   Up 20 minutes             0.0.0.0:8021->8021/tcp, :::8021->8021/tcp                                                           arc-callbacker
2edf9e4c16a5   arc-image:latest              "/service/arc -metam…"   21 minutes ago   Up 20 minutes             0.0.0.0:8001->8001/tcp, :::8001->8001/tcp                                                           lb-metamorph
9fe22388f393   arc-image:latest              "/service/arc -block…"   2 hours ago      Up 20 minutes             0.0.0.0:8011->8011/tcp, :::8011->8011/tcp                                                           arc-blocktx
91fabc670b7b   arc-image                     "/service/arc -api=t…"   2 hours ago      Up 20 minutes             0.0.0.0:9090->9090/tcp, :::9090->9090/tcp                                                           arc
8280e1622824   postgres:14                   "docker-entrypoint.s…"   2 hours ago      Up 20 minutes (healthy)   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp                                                           arc-db
e256290541f4   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   2 hours ago      Up 20 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 0.0.0.0:48332->18332/tcp, :::48332->18332/tcp              arc-node2
e6ad47689ad8   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   2 hours ago      Up 20 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 0.0.0.0:58332->18332/tcp, :::58332->18332/tcp              arc-node3
e2e9e4e1ec42   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   2 hours ago      Up 20 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 28332/tcp, 0.0.0.0:18332->18332/tcp, :::18332->18332/tcp   arc-node1

```

### Balanced microservices

A little hack with docker-compose let us to run multiple instances of API and Metamorph services. Nginx do the magic.

```
docker-compose -f docker-compose-decoupled-lb.yml up
```


Several containers are launched for some services.

```
$ docker ps
CONTAINER ID   IMAGE                         COMMAND                  CREATED         STATUS                   PORTS                                                                                                                                   NAMES
12f31a5c216c   arc-image:latest              "/service/arc -callb…"   3 minutes ago   Up 3 minutes             0.0.0.0:8021->8021/tcp, :::8021->8021/tcp, 0.0.0.0:9994->9994/tcp, :::9994->9994/tcp, 0.0.0.0:9045->9005/tcp, :::9045->9005/tcp         arc-callbacker
b2ec8528249e   nginx:stable-alpine           "/docker-entrypoint.…"   3 minutes ago   Up 3 minutes             0.0.0.0:8001->80/tcp, :::8001->80/tcp                                                                                                   lb-metamorph
15da43cf10df   arc-image:latest              "/service/arc -metam…"   3 minutes ago   Up 3 minutes             0.0.0.0:32812->8001/tcp, :::32812->8001/tcp                                                                                             decoupled_arc-metamorph_5
901375b00103   arc-image:latest              "/service/arc -metam…"   3 minutes ago   Up 3 minutes             0.0.0.0:32807->8001/tcp, :::32807->8001/tcp                                                                                             decoupled_arc-metamorph_8
912c797787b5   arc-image:latest              "/service/arc -metam…"   3 minutes ago   Up 3 minutes             0.0.0.0:32809->8001/tcp, :::32809->8001/tcp                                                                                             decoupled_arc-metamorph_6
a183d135040f   arc-image:latest              "/service/arc -metam…"   3 minutes ago   Up 3 minutes             0.0.0.0:32808->8001/tcp, :::32808->8001/tcp                                                                                             decoupled_arc-metamorph_9
0b8faeb376ef   arc-image:latest              "/service/arc -metam…"   3 minutes ago   Up 3 minutes             0.0.0.0:32810->8001/tcp, :::32810->8001/tcp                                                                                             decoupled_arc-metamorph_10
f66f37a6dd97   arc-image:latest              "/service/arc -metam…"   3 minutes ago   Up 3 minutes             0.0.0.0:32811->8001/tcp, :::32811->8001/tcp                                                                                             decoupled_arc-metamorph_2
ca663941309d   arc-image:latest              "/service/arc -metam…"   3 minutes ago   Up 3 minutes             0.0.0.0:32805->8001/tcp, :::32805->8001/tcp                                                                                             decoupled_arc-metamorph_7
5e53ef269c29   arc-image:latest              "/service/arc -metam…"   3 minutes ago   Up 3 minutes             0.0.0.0:32806->8001/tcp, :::32806->8001/tcp                                                                                             decoupled_arc-metamorph_3
2894429a841f   arc-image:latest              "/service/arc -metam…"   3 minutes ago   Up 3 minutes             0.0.0.0:32804->8001/tcp, :::32804->8001/tcp                                                                                             decoupled_arc-metamorph_4
6674c3027c2d   arc-image:latest              "/service/arc -metam…"   3 minutes ago   Up 3 minutes             0.0.0.0:32803->8001/tcp, :::32803->8001/tcp                                                                                             decoupled_arc-metamorph_1
236d43df401a   nginx:stable-alpine           "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes             80/tcp, 0.0.0.0:9090->9090/tcp, :::9090->9090/tcp                                                                                       arc
782b9534c795   arc-image                     "/service/arc -api=t…"   4 minutes ago   Up 4 minutes             0.0.0.0:32802->9005/tcp, :::32802->9005/tcp, 0.0.0.0:32801->9090/tcp, :::32801->9090/tcp, 0.0.0.0:32800->9999/tcp, :::32800->9999/tcp   decoupled_arc-api_9
7341a9c26d90   arc-image                     "/service/arc -api=t…"   4 minutes ago   Up 4 minutes             0.0.0.0:32793->9005/tcp, :::32793->9005/tcp, 0.0.0.0:32792->9090/tcp, :::32792->9090/tcp, 0.0.0.0:32791->9999/tcp, :::32791->9999/tcp   decoupled_arc-api_2
7e0f1cd4ecd1   arc-image                     "/service/arc -api=t…"   4 minutes ago   Up 4 minutes             0.0.0.0:32796->9005/tcp, :::32796->9005/tcp, 0.0.0.0:32795->9090/tcp, :::32795->9090/tcp, 0.0.0.0:32794->9999/tcp, :::32794->9999/tcp   decoupled_arc-api_6
604d55dccf4d   arc-image                     "/service/arc -api=t…"   4 minutes ago   Up 4 minutes             0.0.0.0:32787->9005/tcp, :::32787->9005/tcp, 0.0.0.0:32786->9090/tcp, :::32786->9090/tcp, 0.0.0.0:32785->9999/tcp, :::32785->9999/tcp   decoupled_arc-api_7
628c92b1e893   arc-image                     "/service/arc -api=t…"   4 minutes ago   Up 4 minutes             0.0.0.0:32799->9005/tcp, :::32799->9005/tcp, 0.0.0.0:32798->9090/tcp, :::32798->9090/tcp, 0.0.0.0:32797->9999/tcp, :::32797->9999/tcp   decoupled_arc-api_3
955dc5b7458a   arc-image                     "/service/arc -api=t…"   4 minutes ago   Up 4 minutes             0.0.0.0:32790->9005/tcp, :::32790->9005/tcp, 0.0.0.0:32789->9090/tcp, :::32789->9090/tcp, 0.0.0.0:32788->9999/tcp, :::32788->9999/tcp   decoupled_arc-api_10
2915aef0f6bb   arc-image                     "/service/arc -api=t…"   4 minutes ago   Up 4 minutes             0.0.0.0:32784->9005/tcp, :::32784->9005/tcp, 0.0.0.0:32783->9090/tcp, :::32783->9090/tcp, 0.0.0.0:32782->9999/tcp, :::32782->9999/tcp   decoupled_arc-api_4
f1887fcf531b   arc-image                     "/service/arc -api=t…"   4 minutes ago   Up 4 minutes             0.0.0.0:32781->9005/tcp, :::32781->9005/tcp, 0.0.0.0:32780->9090/tcp, :::32780->9090/tcp, 0.0.0.0:32779->9999/tcp, :::32779->9999/tcp   decoupled_arc-api_8
732abb86f7ec   arc-image                     "/service/arc -api=t…"   4 minutes ago   Up 4 minutes             0.0.0.0:32778->9005/tcp, :::32778->9005/tcp, 0.0.0.0:32777->9090/tcp, :::32777->9090/tcp, 0.0.0.0:32776->9999/tcp, :::32776->9999/tcp   decoupled_arc-api_5
9bb64bae7b73   arc-image                     "/service/arc -api=t…"   4 minutes ago   Up 4 minutes             0.0.0.0:32775->9005/tcp, :::32775->9005/tcp, 0.0.0.0:32774->9090/tcp, :::32774->9090/tcp, 0.0.0.0:32773->9999/tcp, :::32773->9999/tcp   decoupled_arc-api_1
5e3df16c255a   nginx:stable-alpine           "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes             0.0.0.0:9000->80/tcp, :::9000->80/tcp                                                                                                   dummy-callback
9fe22388f393   arc-image:latest              "/service/arc -block…"   2 hours ago     Up 3 minutes             0.0.0.0:8011->8011/tcp, :::8011->8011/tcp                                                                                               arc-blocktx
8280e1622824   postgres:14                   "docker-entrypoint.s…"   2 hours ago     Up 4 minutes (healthy)   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp                                                                                               arc-db
e256290541f4   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   2 hours ago     Up 4 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 0.0.0.0:48332->18332/tcp, :::48332->18332/tcp                                                  arc-node2
e6ad47689ad8   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   2 hours ago     Up 4 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 0.0.0.0:58332->18332/tcp, :::58332->18332/tcp                                                  arc-node3
e2e9e4e1ec42   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   2 hours ago     Up 4 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 28332/tcp, 0.0.0.0:18332->18332/tcp, :::18332->18332/tcp                                       arc-node1


```


## Batching transactions

It is possible to perform batch transactions to test the deployment. The "cmd" utilities are useful for doing speficic and isolated operations with ARC. In this case we can use "broadcaster" to order transactions through ARC.

NOTE: You have to clone the github repo and put your own config.yml in the root of your copy to get the broadcaster working properly.


```
go run cmd/broadcaster/main.go -api=true -consolidate -authorization=mainnet_XXX -batch=100 1000

```


NOTE2: broadcaster in "cmd" fashion doesn't support option "-config". I've done by my own to launch the same more confortable:

```
go run cmd/broadcaster/main.go -config=../arc_cover/decoupled/ -api=true -consolidate -authorization=mainnet_XXX -batch=100 1000

```


## Dummy third app

It could be interesting to receive those "post" that the callbacker sends back to the customer application, even if they are corresponding to a tests like the mentioned above. For that reason, we have included a dummy callback receiver that logs any POST sent back to 0.0.0.0:9000 from ARC.

Why 0.0.0.0:9000 ? Just because this endpoint is for now hardcoded and we are trying to test directly from uploaded branches.


## Digging into database data

We can open a console directly to the container to do the full reseach:

```
$ docker exec -it arc-db bash
```

Connection to the data base

```
# psql -h localhost -U arcuser blocktx
```

List of tables
```
blocktx-# \dt
 public | block_transactions_map | table | arcuser
 public | blocks                 | table | arcuser
 public | primary_blocktx        | table | arcuser
 public | schema_migrations      | table | arcuser
 public | transactions           | table | arcuser
```

We can show the schema for the table "transactions"
```
blocktx=# \d transactions
 id          | bigint                   |           | not null | nextval('transactions_id_seq'::regclass)
 hash        | bytea                    |           | not null | 
 source      | text                     |           |          | 
 merkle_path | text                     |           |          | ''::text
 inserted_at | timestamp with time zone |           | not null | CURRENT_TIMESTAMP
```

Querying data from the table
```
blocktx=# SELECT  * from transactions limit 10;
```

Storage used by this table
```
blocktx=# \dt+ transactions
 public | transactions | table | arcuser | permanent   | heap          | 2192 kB |
```



# Querying bitcoin nodes


```
curl --user 'bitcoin:bitcoin'   \
    --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getinfo","params":[]}' \
    -H 'content-type:text/plain;' \
    http://127.0.0.1:18332

```