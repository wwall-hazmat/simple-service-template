output "ecs_cluster_name" {
  value = aws_ecs_cluster._.name
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster._.id
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster._.arn
}

output "ecs_cloudwatch_group_name" {
  value = aws_cloudwatch_log_group._.name
}
