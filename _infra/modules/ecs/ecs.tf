resource "aws_ecs_cluster" "_" {
  name = local.name_prefix

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(
    local.environment_tags,
    {
      "Name" = local.name_prefix
    },
  )
}
