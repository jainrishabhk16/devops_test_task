 #Create an ALB
resource "aws_lb" "test_task_alb" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = var.load_balancer_type
  subnets            = var.public_subnets
  # security_groups    = [aws_security_group.alb.id]
  security_groups    = [var.lb_id]

}

resource "aws_lb_target_group" "http_target_group" {
  name        = var.http_target_group_name
  port        = var.target_group_port # Replace with your service port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id # Replace with your VPC ID
  target_type = var.target_group_type
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.test_task_alb.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http_target_group.arn
  }
}