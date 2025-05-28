variable "app_metadata" {
  description = <<EOF
Nullstone automatically injects metadata from the app module into this module through this variable.
This variable is a reserved variable for capabilities.
EOF

  type    = map(string)
  default = {}
}

locals {
  log_group_name      = var.app_metadata["log_group_name"]
  execution_role_name = var.app_metadata["execution_role_name"]
}

variable "use_grpc" {
  type        = bool
  default     = false
  description = "Enable to use gRPC instead of HTTP for OTEL_EXPORTER_OTLP_ENDPOINT environment variable"
}

locals {
  otlp_endpoint = var.use_grpc ? "http://localhost:4317" : "http://localhost:4318"
}
