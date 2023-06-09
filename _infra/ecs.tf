module "ecs" {
  source = "./modules/ecs"
  app_name = var.workload
}