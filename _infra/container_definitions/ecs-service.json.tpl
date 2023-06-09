[
  {
    "name": "${container_name}",
    "memory": ${memory},
    "cpu": ${cpu},
    "image": "${ecr_repository_url}:${ecr_image_tag}",
    "essential": true,
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "${container_name}-log-group",
            "awslogs-region": "us-east-1",
            "awslogs-create-group": "true",
            "awslogs-stream-prefix": "${container_name}-log-stream"
        }
    },
    "portMappings": [
      {
        "hostPort": ${container_port},
        "protocol": "tcp",
        "containerPort": ${container_port}
      },
      {
        "hostPort": 9012,
        "protocol": "tcp",
        "containerPort": 9012
      }
    ],
    "mountPoints": [],
    "volumesFrom": [],
    "environment": []
  }
]