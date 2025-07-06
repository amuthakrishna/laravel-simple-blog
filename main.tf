module "ecs" {
  source                       = "./modules/ECS"
  aws_lb_name                  = "alb"
  aws_lb_target_group_name     = "alb-target"
  aws_lb_target_group_port     = 8000
  aws_ecs_cluster              = "mycluster"
  cloud_watch_name             = "/ecs/my-ecs-service"
  aws_ecs_service_name         = "ecs-service"
  container_image              = "krishnamoorthy1/simple-blog:IMAGE_TAG"
  aws_ecs_task_definition_name = "mytask"
}