output "codedeploy_app_name" {
  value = aws_codedeploy_app.strapi_app.name
}

output "codedeploy_app_id" {
  value = aws_codedeploy_app.strapi_app.id
}

output "deployment_group_name" {
  value = aws_codedeploy_deployment_group.strapi_deployment_group.deployment_group_name
}