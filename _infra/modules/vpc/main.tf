resource "aws_vpc" "_" {
  cidr_block                       = var.vpc_cidr
  enable_dns_hostnames             = true
  tags = local.environment_tags
}

data "aws_availability_zones" "_" {
  state = "available"
}

data "aws_availability_zone" "_" {
  for_each = toset(var.az_ids)
  zone_id  = each.value
}

resource "random_shuffle" "az" {
  input        = data.aws_availability_zones._.names
  result_count = var.availability_zone_count
}

resource "aws_subnet" "public" {
  count                   = var.availability_zone_count
  vpc_id                  = aws_vpc._.id
  map_public_ip_on_launch = true
  cidr_block              = cidrsubnet(aws_vpc._.cidr_block, ceil(log(var.availability_zone_count * 2, 2)), count.index)
  availability_zone       = length(var.az_ids) == 0 ? random_shuffle.az.result[count.index] : data.aws_availability_zone._[var.az_ids[count.index]].name
}

resource "aws_subnet" "private" {
  count             = var.availability_zone_count
  vpc_id            = aws_vpc._.id
  cidr_block        = cidrsubnet(aws_vpc._.cidr_block, ceil(log(var.availability_zone_count * 2, 2)), count.index + var.availability_zone_count)
  availability_zone = length(var.az_ids) == 0 ? random_shuffle.az.result[count.index] : data.aws_availability_zone._[var.az_ids[count.index]].name
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc._.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc._.id
}

resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public" {
  count          = var.availability_zone_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc._.id
}

resource "aws_route_table_association" "private" {
  count          = var.availability_zone_count
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

locals {
  route_table_ids = concat(aws_route_table.private[*].id, [aws_route_table.public.id])
}
