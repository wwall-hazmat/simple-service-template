locals {
  name_prefix = "${var.app_name}-ecs-cluster"
}

# tags
locals {
  environment_tags = {
    "Name" = var.app_name
  }
}
