# Datadog Logs/Metrics for ECS/Fargate

This capability sends application logs and metrics to Datadog for ECS (Fargate-based or EC2-based).

## Logs

Application logs are configured to send to Datadog in near real-time. (<1 min latency)
These logs are tagged with `stack`, `block`, and `env`.

The application logs are immediately sent to Cloudwatch and transmitted to Datadog via Kinesis Firehose.

## Metrics

The Datadog agent is added to your application as a sidecar container.
This agent collects metrics from AWS and custom metrics from your application and sends them to Datadog in near real-time.
