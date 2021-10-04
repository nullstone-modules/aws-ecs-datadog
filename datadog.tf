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
