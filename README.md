# Datadog Logs/Metrics for ECS/Fargate

This capability sends application logs and metrics to Datadog for ECS (Fargate-based or EC2-based).

## Logs

Application logs are configured to send to Datadog in near real-time. (<1 min latency)
They are immediately sent to Cloudwatch and transmitted to Datadog via Kinesis Firehose.

These logs are tagged with `stack`, `block`, and `env`.
Additionally, this module adds a log pipeline to do the following:
- Create attribute and tag `container` that represents the container name. (useful to filter out logs from sidecars including the datadog agent)
- Create attribute and tag `task_id` that represents the ECS task id. (useful for differentiating different tasks)

## Metrics

The Datadog agent is added to your application as a sidecar container.
This agent collects metrics from ECS/Fargate and sends them to Datadog in near real-time.

The Datadog agent automatically discovers metadata about the service and attributes to the metrics.
This includes information about the ECS/Fargate task, ECS/Fargate cluster, availability zone, region, and more.

### OpenTelemetry (APM, Traces)

For custom metrics and traces, the Datadog agent is configured to run as an OpenTelemetry collector that forwards to Datadog.

The agent is configured to listen on port 4317 (gRPC) and 4318 (HTTP).
This module automatically injects `OTEL_EXPORTER_OTLP_ENDPOINT` env var into the app.
If you use a standard OpenTelemetry library, it will use this env var to connect to the listener.
By default, this is configured to connect to the HTTP listener.
If you enable `var.use_grpc`, this env var will refer to the gRPC listener instead.

This module automatically configures the OpenTelemetry collector to tag custom metrics/traces with `service.name` and `deployment.environment`.
If you would like more metadata, you will need to configure your OpenTelemetry configuration to add additional resource attributes.
