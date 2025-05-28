output "env" {
  value = [
    {
      name  = "OTEL_EXPORTER_OTLP_ENDPOINT"
      value = local.otlp_endpoint
    }
  ]
}

output "sidecars" {
  value = [
    local.agent_sidecar
  ]
}
