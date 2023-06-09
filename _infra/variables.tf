variable "availability_zone_count" {
  type    = number
  default = 2
}

variable "vpc_cidr" {
  type = string
  default = "172.16.0.0/16"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "env" {
  type = string
  default = "staging"
}

variable "workload" {
  type    = string
  default = "simple-service"
}

variable "desired_count" {
  type = number
  default = 1
}

variable "ecs_deployment_type" {
  type = string
  default = "ECS"
}

variable "ecs_service_config" {
  type = object ({
    app_name                                = string
    ecs_deployment_type                     = string
    ecr_repository_url                      = string
    ecr_image_tag                           = string
    app_port                                = number
    memory                                  = number
    cpu                                     = number
    container_count                         = number
  })
  default = {
      app_name                                = "simple-service"
      ecs_deployment_type                     = "ECS" // changed from ECS_FARGATE To ECS: expected deployment_controller.0.type to be one of [ECS CODE_DEPLOY EXTERNAL], got ECS_FARGATE
      ecr_repository_url                      = "062840989199.dkr.ecr.us-east-1.amazonaws.com/simple-service-template" // THIS NEEDS TO BE UPDATED IN ECR ACCOUNT TO HAVE PAS AS UPPER DIRECTORY
      ecr_image_tag                           = "latest"
      app_port                                = 8080
      memory                                  = 4096
      cpu                                     = 2048
      container_count                         = 2
    }
}

