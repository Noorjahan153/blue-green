output "blue_tg_arn" {
  description = "ARN of Blue target group"
  value       = aws_lb_target_group.blue.arn
}

output "blue_tg_name" {
  description = "Name of Blue target group"
  value       = aws_lb_target_group.blue.name
}

output "green_tg_arn" {
  description = "ARN of Green target group"
  value       = aws_lb_target_group.green.arn
}

output "green_tg_name" {
  description = "Name of Green target group"
  value       = aws_lb_target_group.green.name
}

output "listener_arn" {
  description = "HTTP listener ARN"
  value       = aws_lb_listener.http.arn
}

output "alb_dns_name" {
  description = "Public DNS of ALB"
  value       = aws_lb.this.dns_name
}
