resource "aws_ecs_task_definition" "app" {
  family                   = var.aws_ecs_task_definition_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn # Optional

  container_definitions = jsonencode([{
    name      = "app-container",
    image     = var.container_image, # Replace with your image
    essential = true,
    portMappings = [{
      containerPort = 8000,
      hostPort      = 8000
    }],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"  = aws_cloudwatch_log_group.ecs_logs.name
        "awslogs-region" = "ap-south-1"
        "awslogs-stream-prefix" = "ecs" 
      }
    },
    environment = [
      { name = "NODE_ENV", value = "production" },
      { name = "DB_CONNECTION", value = "mysql" },
      { name = "DB_HOST", value = "43.204.37.250" },
      { name = "DB_PORT", value = "3306" },
      { name = "DB_DATABASE", value = "laravel" },
      { name = "DB_USERNAME", value = "aduser" },
      { name = "DB_PASSWORD", value = "aduser" }
    ]
  }])

  tags = {
    Service = "my-app"
  }
}