locals {
  container_definition = templatefile("./container_definitions/ecs-service.json.tpl", {
    container_name                            = "${var.ecs_service_config["app_name"]}-container"
    container_port                            = var.ecs_service_config["app_port"]
    ecr_repository_url                        = var.ecs_service_config["ecr_repository_url"]
    ecr_image_tag                             = var.ecs_service_config["ecr_image_tag"]
    cpu                                       = var.ecs_service_config["cpu"]
    memory                                    = var.ecs_service_config["memory"]
  })
}