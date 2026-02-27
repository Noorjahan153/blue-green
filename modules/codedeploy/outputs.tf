output "codedeploy_app_name" {
  description = "CodeDeploy application name"
  value       = aws_codedeploy_app.this.name
}

output "codedeploy_app_id" {
  description = "CodeDeploy application ID"
  value       = aws_codedeploy_app.this.id
}

output "deployment_group_name" {
  description = "CodeDeploy deployment group name"
  value       = aws_codedeploy_deployment_group.this.deployment_group_name
}
