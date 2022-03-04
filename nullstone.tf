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

// Generate a random suffix to ensure uniqueness of resources
resource "random_string" "resource_suffix" {
  length  = 5
  lower   = true
  upper   = false
  number  = false
  special = false
}

locals {
  tags          = data.ns_workspace.this.tags
  block_name    = data.ns_workspace.this.block_name
  resource_name = "${data.ns_workspace.this.block_ref}-${random_string.resource_suffix.result}"
}

data "ns_connection" "datadog" {
  name = "datadog"
  type = "datadog/aws"
}

locals {
  delivery_stream_arn = data.ns_connection.datadog.outputs.delivery_stream_arn
  delivery_role_arn   = data.ns_connection.datadog.outputs.delivery_role_arn
  api_key_secret_id   = data.ns_connection.datadog.outputs.api_key_secret_id
  app_key_secret_id   = data.ns_connection.datadog.outputs.app_key_secret_id
}
