
# Monitoring

Prometheus can collect ARC metrics. It improves observability in production and enables debugging during development and deployment. As Prometheus is a very standard tool for monitoring, any other complementary tool such as Grafana and others can be added for better data analysis.

Prometheus periodically poll the system data by querying specific urls.

## Enabling monitoring

Enable monitoring consists of setting the **prometheusEndpoint" property in config.yaml file:

```
profilerAddr: 0.0.0.0:9999 # address to start profiler server on
prometheusEndpoint: /metrics # endpoint for prometheus metrics

```

The full url for the Prometheus endpoint also uses the "profileAddr" property. In this example, the URL is http://0.0.0.0:9999/metrics.


Monitoring data are as follows:

```
# HELP arc_blocktx_peer_block_announcement_count Shows the number of blocks announced by the peer handler
# TYPE arc_blocktx_peer_block_announcement_count counter
arc_blocktx_peer_block_announcement_count{peer="node1:18333"} 268
arc_blocktx_peer_block_announcement_count{peer="node2:18333"} 321
arc_blocktx_peer_block_announcement_count{peer="node3:18333"} 344
# HELP arc_blocktx_peer_block_count Shows the number of blocks received by the peer handler
# TYPE arc_blocktx_peer_block_count counter
arc_blocktx_peer_block_count{peer="node1:18333"} 155
arc_blocktx_peer_block_count{peer="node2:18333"} 170
arc_blocktx_peer_block_count{peer="node3:18333"} 192
# HELP arc_blocktx_peer_block_processing_ms Shows the total time spent processing blocks by the peer handler
# TYPE arc_blocktx_peer_block_processing_ms counter
arc_blocktx_peer_block_processing_ms{peer="node1:18333"} 2907
arc_blocktx_peer_block_processing_ms{peer="node2:18333"} 2745
arc_blocktx_peer_block_processing_ms{peer="node3:18333"} 3041
[...]
```

