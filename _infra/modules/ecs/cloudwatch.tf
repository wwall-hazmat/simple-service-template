resource "aws_cloudwatch_log_group" "_" {
  name = "${local.name_prefix}-cloudwatch-group"

  tags = merge(
    local.environment_tags,
    {
      "Name" = "${local.name_prefix}-cloudwatch-group"
    },
  )
}