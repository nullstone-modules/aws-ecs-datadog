output "env" {
  value = [
    {
      name  = "OTEL_EXPORTER_OTLP_ENDPOINT"
      value = "http://localhost:4318"
    }
  ]
}

output "sidecars" {
  value = [
    local.agent_sidecar
  ]
}
