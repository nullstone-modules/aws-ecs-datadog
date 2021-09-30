output "log_configurations" {
  value = [
    {
      provider  = "datadog"
      logDriver = "awsfirelens"
      options = jsonencode({
        "Name"           = "datadog"
        "Host"           = "http-intake.logs.datadoghq.com"
        "TLS"            = "on"
        "dd_service"     = data.ns_workspace.this.block_name
        "dd_source"      = "httpd"
        "dd_message_key" = "log"
        "dd_tags"        = "stack=${data.ns_workspace.this.stack_name}, env:${data.ns_workspace.this.env_name}"
        "provider"       = "ecs"
      })
      secretOptions = jsonencode([
        {
          name : "apikey",
          valueFrom : data.ns_connection.datadog.outputs.api_key_secret_id
        }
      ])
    }
  ]
}

locals {
  json_fl_options = {
    enable-ecs-log-metadata = "true"
    config-file-type        = "file"
    config-file-value       = "/fluent-bit/configs/parse-json.conf"
  }
  normal_fl_options = {
    enable-ecs-log-metadata = "true"
  }

  fl_options = var.json_output ? local.json_fl_options : local.normal_fl_options
}

output "sidecars" {
  value = [
    {
      name      = "log-router"
      image     = "amazon/aws-for-fluent-bit:2.19.0"
      essential = true
      firelensConfiguration = jsonencode({
        type    = "fluentbit"
        options = local.fl_options
      })
    }
  ]
}
