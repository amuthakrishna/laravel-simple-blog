resource "aws_ecs_cluster" "main" {
  name = var.aws_ecs_cluster

  setting {
    name  = "containerInsights"
    value = "enabled" # Enable detailed monitoring
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = var.cloud_watch_name
  retention_in_days = 14 # Adjust as needed
}