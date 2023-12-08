# Tracing

Tracing can be enabled using flags (-tracer=true) or setting up the config.yaml file. 

```
[...]
tracing: true # enable trancing
[...]
```

## Jaeger

Events are spanned to [Jaeger](https://www.jaegertracing.io/).

<!-- As a reminderm, defaults ports in jaeger:


| Port	| Protocol	| Component	| Function |
| -----| -----| -----| -----|
|6831 |UDP	    |agent	|accept jaeger.thrift over Thrift-compact protocol (used by most SDKs)|
|6832	|UDP	|agent	|accept jaeger.thrift over Thrift-binary protocol (used by Node.js SDK)|
|5778	|HTTP	|agent	|serve configs (sampling, etc.)|
|16686	|HTTP	|query	|serve frontend|
|4317	|HTTP	|collector	|accept OpenTelemetry Protocol (OTLP) over gRPC|
|4318	|HTTP	|collector	|accept OpenTelemetry Protocol (OTLP) over HTTP|
|14268	|HTTP	|collector	|accept jaeger.thrift directly from clients|
|14250	|HTTP	|collector	|accept model.proto|
|9411	|HTTP	|collector	|Zipkin compatible endpoint (optional)| -->


Jaeger can run as a docker container. 

```
docker run  -p 16686:16686 -p 4317:4317 -p 14269:14269 jaegertracing/all-in-one:latest
```


Jaeger frontend let analyze the traces. By default, Jaeger URL in a local env is [http://localhost:16686/search](http://localhost:16686/search).


