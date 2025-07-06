# alb.tf variables
variable "aws_lb_name" {
  description = "aws_lb_name"
  type        = string
}

variable "aws_lb_target_group_name" {
  description = "aws_lb_target_group_name"
  type        = string
}

variable "aws_lb_target_group_port" {
  description = "aws_lb_target_group_port"
  type        = number
}

# ECS Cluster Variables
variable "aws_ecs_cluster" {
  description = "aws_ecs_cluster"
  type        = string

}

variable "cloud_watch_name" {
  description = "cloud_watch_name"
  type        = string

}

# ECS Service variable
variable "aws_ecs_service_name" {
  description = "aws_ecs_service_name"
  type        = string

}


variable "container_image" {
  description = "container_image"
  type        = string

}

variable "aws_ecs_task_definition_name" {
  description = "aws_ecs_task_definition_name"
  type        = string

}
