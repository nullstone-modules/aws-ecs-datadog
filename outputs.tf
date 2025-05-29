output "env" {
  value = [
    {
      name  = "OTEL_EXPORTER_OTLP_ENDPOINT"
      value = local.otlp_endpoint
    },
    {
      name  = "DD_ENV"
      value = local.env_name
    },
    {
      name  = "DD_SERVICE"
      value = local.block_name
    }
  ]
}

output "sidecars" {
  value = [
    local.agent_sidecar
  ]
}
