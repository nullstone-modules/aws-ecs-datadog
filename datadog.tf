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

data "aws_secretsmanager_secret_version" "app_key" {
  secret_id = local.app_key_secret_id
}

data "aws_secretsmanager_secret_version" "api_key" {
  secret_id = local.api_key_secret_id
}

provider "datadog" {
  api_key = data.aws_secretsmanager_secret_version.api_key.secret_string
  app_key = data.aws_secretsmanager_secret_version.app_key.secret_string
}
