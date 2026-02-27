terraform {
  backend "s3" {
    bucket         = "noor-terraform-state"
    key            = "bluegreen/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

############################################
# VPC
############################################

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

############################################
# Security Groups
############################################

module "security_groups" {
  source       = "./modules/security_groups"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

############################################
# ALB
############################################

module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
  alb_sg_id      = module.security_groups.alb_sg_id
  project_name   = var.project_name
}

############################################
# ECR
############################################

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "strapi-bluegreen"
}

############################################
# RDS
############################################

module "rds" {
  source = "./modules/rds"

  project_name    = var.project_name
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  ecs_sg_id = module.security_groups.ecs_sg_id

  db_name     = "strapidb"
  db_username = var.db_username
  db_password = var.db_password
}

############################################
# ECS
############################################

module "ecs" {
  source          = "./modules/ecs"
  private_subnets = module.vpc.private_subnets
  ecs_sg_id       = module.security_groups.ecs_sg_id
  blue_tg_arn     = module.alb.blue_tg_arn
  project_name    = var.project_name

  db_host     = module.rds.db_endpoint
  db_username = var.db_username
  db_password = var.db_password
}

############################################
# CodeDeploy
############################################

module "codedeploy" {
  source        = "./modules/codedeploy"

  cluster_name  = module.ecs.cluster_name
  service_name  = module.ecs.service_name
  blue_tg_name  = module.alb.blue_tg_name
  green_tg_name = module.alb.green_tg_name
  listener_arn  = module.alb.listener_arn
}