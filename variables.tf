variable "region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "bluegreen-app"
}

variable "db_username" {
  description = "RDS PostgreSQL username"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "RDS PostgreSQL password"
  type        = string
  sensitive   = true
}