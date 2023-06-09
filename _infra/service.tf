resource "aws_ecs_service" "ecs_service" {
  name             = "${var.workload}-ecs-service"
  cluster          = module.ecs.ecs_cluster_id
  task_definition  = aws_ecs_task_definition._.arn
  desired_count    = var.desired_count
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  propagate_tags   = "SERVICE"

  deployment_controller {
    type = var.ecs_deployment_type
  }

  network_configuration {
    assign_public_ip = true
    subnets          = module.vpc.public_subnet_ids
    security_groups  = [aws_security_group.ecs-service.id]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_task_definition" "_" {
  container_definitions    = replace(local.container_definition, "/[<>]/", "")
  family                   = "${var.ecs_service_config["app_name"]}-task-def"
  execution_role_arn       = aws_iam_role.execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_service_config["cpu"]
  memory                   = var.ecs_service_config["memory"]
  network_mode             = "awsvpc"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}
