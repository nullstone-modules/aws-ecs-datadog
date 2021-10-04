terraform {
  required_providers {
    ns = {
      source = "nullstone-io/ns"
    }
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

data "ns_workspace" "this" {}

variable "app_metadata" {
  description = <<EOF
App Metadata is injected from the app on-the-fly.
This contains information about resources created in the app module that are needed by the capability.
EOF

  type    = map(string)
  default = {}
}

data "ns_connection" "datadog" {
  name = "datadog"
  type = "telemetry/datadog/aws"
}

locals {
  delivery_stream_arn = data.ns_connection.datadog.outputs.delivery_stream_arn
  delivery_role_arn   = data.ns_connection.datadog.outputs.delivery_role_arn
  api_key_secret_id   = data.ns_connection.datadog.outputs.api_key_secret_id
  app_key_secret_id   = data.ns_connection.datadog.outputs.app_key_secret_id
}
