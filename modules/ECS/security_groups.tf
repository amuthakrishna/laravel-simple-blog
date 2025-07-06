# ALB Security Group
resource "aws_security_group" "alb" {
  name        = "alb-sg-test"
  description = "Allow HTTP/HTTPS traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ECS Service Security Group
resource "aws_security_group" "ecs_service" {
  name        = "ecs-service-sg-test"
  description = "Restrict traffic to ALB only"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port       = 8000 # Match container port
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}