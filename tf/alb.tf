

resource "aws_lb" "alb" {
  name               = "flask-react-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.cluster-security-group}"]
  subnets            = [
    "${var.subnet-a}",
    "${var.subnet-b}"
  ]
  enable_deletion_protection = false

  tags = {
    Environment = "Devops-AWS-ECS"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${var.fe-target-group}"
  }
}


resource "aws_lb_listener_rule" "listener_rule_be" {
  listener_arn = aws_lb_listener.front_end.arn
  
  action {
    type             = "forward"
    target_group_arn = "${var.be-target-group}"
  }

  condition {
    path_pattern {
      values = ["/doc", "/tweet*", "/login", "/fastlogin"]
    }
  }

}