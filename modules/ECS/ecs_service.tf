resource "aws_ecs_service" "main" {
  name            = var.aws_ecs_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = true # Required for Fargate in default VPC
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "app-container"
    container_port   = var.aws_lb_target_group_port
  }

  # Optional: Auto-scaling configuration
  # depends_on = [aws_appautoscaling_target.ecs_target]

  tags = {
    Service = "my-app"
  }
}