resource "aws_ecs_cluster" "strapi_cluster" {
  name = "${var.project_name}-cluster"
}

resource "aws_ecs_task_definition" "strapi_task" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = "arn:aws:iam::055013504553:role/ecs_fargate_taskRole"

  container_definitions = jsonencode([
    {
      name  = "strapi-container"
      image = "055013504553.dkr.ecr.us-east-1.amazonaws.com/strapi-bluegreen:latest"

      portMappings = [
        {
          containerPort = 1337
        }
      ]

      environment = [
        { name = "APP_KEYS", value = "testKey1,testKey2,testKey3,testKey4" },
        { name = "API_TOKEN_SALT", value = "testSalt" },
        { name = "ADMIN_JWT_SECRET", value = "testAdminSecret" },
        { name = "JWT_SECRET", value = "testJwtSecret" }
      ]
    }
  ])
}

resource "aws_ecs_service" "strapi_service" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.strapi_cluster.id
  task_definition = aws_ecs_task_definition.strapi_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  health_check_grace_period_seconds = 60

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  lifecycle {
    ignore_changes = [
      load_balancer,
      task_definition,
    ]
  }

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.blue_tg_arn
    container_name    = "strapi-container"
    container_port    = 1337
  }
}