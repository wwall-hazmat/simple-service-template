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
  default = "us-west-2"
}

variable "env" {
  type = string
  default = "staging"
}

variable "workload" {
  type    = string
}

variable "az_ids" {
  type    = list(string)
  default = []
}