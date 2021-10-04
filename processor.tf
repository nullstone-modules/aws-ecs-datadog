resource "datadog_logs_custom_pipeline" "service" {
  name       = local.resource_name
  is_enabled = true

  filter {
    query = "source:${var.app_metadata["log_group_name"]}"
  }


  processor {
    string_builder_processor {
      target             = "service"
      template           = data.ns_workspace.this.block_name
      name               = "service name"
      is_enabled         = true
      is_replace_missing = true
    }
  }
}
