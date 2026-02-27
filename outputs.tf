
output "alb_dns_name" {
  description = "Public DNS of Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "ecs_cluster_name" {
  description = "ECS Cluster name"
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "ECS Service name"
  value       = module.ecs.service_name
}

output "codedeploy_app_name" {
  description = "CodeDeploy application name"
  value       = module.codedeploy.codedeploy_app_name
}

output "deployment_group_name" {
  description = "CodeDeploy deployment group name"
  value       = module.codedeploy.deployment_group_name
}
