output "log_configurations" {
  value = [
    {
      logDriver = "awsfirelens"
      options = jsonencode({
        "Name" : "datadog",
        "Host" : "http-intake.logs.datadoghq.com",
        "TLS" : "on",
        "dd_service" : data.ns_workspace.this.block_name,
        "dd_source" : "httpd",
        "dd_tags" : "stack:${data.ns_workspace.this.stack_name}, env:${data.ns_workspace.this.env_name}",
        "provider" : "ecs"
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
