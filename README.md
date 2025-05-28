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
This agent collects metrics from AWS and custom metrics from your application and sends them to Datadog in near real-time.

### OpenTelemetry

The Datadog agent is configured as an OpenTelemetry agent with a gRPC listener on port 4317 and HTTP listener on port 4318.
This module automatically injects `OTEL_EXPORTER_OTLP_ENDPOINT` environment variable into the app.
If you use a standard OpenTelemetry library, it will use this environment variable to connect to the HTTP listener.
If you enable `var.use_grpc`, this environment variable will refer to the gRPC listener instead.
