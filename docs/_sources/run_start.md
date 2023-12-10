# Starting ARC


Let's start at the beginning. Regardless of the database you are going to use, or blockchain you are targeting, etc... you need the program compiled and ready to run.

```
git clone https://github.com/bitcoin-sv/arc
cd arc
make build_release
```


The resulting binary is at  ./build/arc_linux_amd64. 

A typical (naive) run of the main binary could look line this:

```
 ./build/arc_linux_amd64 
2023/12/01 17:30:47 WARN: No config file 'settings.conf'
2023/12/01 17:30:47 WARN: No local config file 'settings_local.conf'
time=2023-12-01T17:30:47.824+01:00 level=INFO msg="starting arc" version="" commit=""
time=2023-12-01T17:30:47.824+01:00 level=INFO msg="Starting prometheus" endpoint=/metrics
time=2023-12-01T17:30:47.824+01:00 level=INFO msg="Starting tracer"
time=2023-12-01T17:30:47.825+01:00 level=INFO msg="Starting profiler on http://localhost:9999/debug/pprof"
time=2023-12-01T17:30:47.825+01:00 level=INFO msg="No service selected, starting all"
time=2023-12-01T17:30:47.825+01:00 level=INFO msg="Starting BlockTx"
2023/12/01 17:30:47 | Stat.go:199         | stats| INFO  | Starting StatsServer on http://localhost:9005/stats
2023/12/01 17:30:47 | logger.go:157       | btx  | INFO  | Socket created. Connect with 'nc -U /tmp/gocore/BTX.sock'
2023/12/01 17:30:47 | sql.go:136          | btsql| INFO  | Using sqlite DB: /tmp/arc/data/blocktx.db?cache=shared&_pragma=busy_timeout=10000&_pragma=journal_mode=WAL
2023/12/01 17:30:47 | logger.go:157       | btsql| INFO  | Socket created. Connect with 'nc -U /tmp/gocore/BTSQL.sock'
2023/12/01 17:30:47 | logger.go:157       | stats| INFO  | Socket created. Connect with 'nc -U /tmp/gocore/STATS.sock'
2023/12/01 17:30:47 | PeerManager.go:41   | btx  | INFO  | Excessive block size set to 4000000000
2023/12/01 17:30:47 | Peer.go:157         | btx  | INFO  | [localhost:18333] Connecting to peer on TestNet
2023/12/01 17:30:47 | Peer.go:91          | btx  | WARN  | Failed to connect to peer localhost:18333: could not dial node [localhost:18333]: dial tcp 127.0.0.1:18333: connect: connection refused
time=2023-12-01T17:30:47.879+01:00 level=INFO msg="Starting Callbacker"
2023/12/01 17:30:47 | Peer.go:157         | btx  | INFO  | [localhost:18334] Connecting to peer on TestNet
2023/12/01 17:30:47 | blocktx.go:45       | btx  | FATAL | SQL logic error: no such table: primary_blocktx (1)
2023/12/01 17:30:47 | Peer.go:91          | btx  | WARN  | Failed to connect to peer localhost:18334: could not dial node [localhost:18334]: dial tcp 127.0.0.1:18334: connect: connection refused
2023/12/01 17:30:47 | logger.go:162       | btx  | WARN  | Accept error: accept unix /tmp/gocore/BTX.sock: use of closed network connection
```


The perfect ARC deployment requires making many decisions about databases, networking, interface with the bitcoin network, etc.. In this repo ([https://github.com/rloadd/on_arc](https://github.com/rloadd/on_arc)) we provide some examples on how to run everything in a toy deployment. Do your own research on the repo content and if you feel safe, try it like this:



```
git clone https://github.com/rloadd/on_arc
cd on_arc/monolithic
docker-compose up 

```





