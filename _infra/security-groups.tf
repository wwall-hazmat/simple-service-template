resource "aws_security_group" "ecs-service" {
  name        = "${var.workload}-sg"
  description = "Controls traffic into and out of cluster"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "service_to_internet_http" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow http traffic to the internet"
  security_group_id = aws_security_group.ecs-service.id
}

resource "aws_security_group_rule" "service_to_internet_https" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow traffic to the internet"
  security_group_id = aws_security_group.ecs-service.id
}

resource "aws_security_group_rule" "service_to_sql" {
  type        = "egress"
  from_port   = 1433
  to_port     = 1433
  protocol    = "TCP"
  description = "Allow traffic to the db"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs-service.id
}

resource "aws_security_group_rule" "inbound_anywhere" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs-service.id
}