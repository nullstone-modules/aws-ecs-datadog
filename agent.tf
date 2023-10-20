output "sidecars" {
  value = [
    {
      name         = "datadog-agent"
      image        = "public.ecr.aws/datadog/agent:latest"
      essential    = true
      portMappings = jsonencode([
        { protocol = "tcp", containerPort = 8126 },
      ])
      environment  = jsonencode([
        { name = "ECS_FARGATE", value = "true" },
        { name = "DD_APM_ENABLED", value = "true" },
        { name = "DD_SITE", value = "datadoghq.com" }
      ])
      secrets = jsonencode([{ name = "DD_API_KEY", valueFrom = local.api_key_secret_id }])
    }
  ]
}

resource "aws_iam_role_policy_attachment" "execution-datadog" {
  role       = local.execution_role_name
  policy_arn = aws_iam_policy.datadog.arn
}

resource "aws_iam_policy" "datadog" {
  name   = "${local.resource_name}-datadog"
  policy = data.aws_iam_policy_document.datadog.json
}

data "aws_iam_policy_document" "datadog" {
  statement {
    sid       = "AllowReadDatadogApiKey"
    effect    = "Allow"
    resources = [local.api_key_secret_id]

    actions = [
      "secretsmanager:GetSecretValue",
      "kms:Decrypt"
    ]
  }
}
