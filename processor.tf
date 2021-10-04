// The cloudwatch log group name is used as the "service" in datadog
// This pipeline will set the block name based on this log group, then remap the service name to this block name
resource "datadog_logs_custom_pipeline" "service" {
  name       = local.resource_name
  is_enabled = true

  filter {
    query = "source:${var.app_metadata["log_group_name"]}"
  }


  processor {
    string_builder_processor {
      target             = "block"
      template           = data.ns_workspace.this.block_name
      name               = "block name"
      is_enabled         = true
      is_replace_missing = true
    }
  }

  processor {
    service_remapper {
      sources    = ["block"]
      is_enabled = true
      name       = "remap service name"
    }
  }
}
