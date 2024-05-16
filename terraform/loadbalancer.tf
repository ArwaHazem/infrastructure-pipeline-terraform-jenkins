
resource "aws_lb" "alb" {
  name               = "nodejs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [module.network.subnets["public-subnet-1"].id, module.network.subnets["public-subnet-2"].id,]
  tags = {
    Name = "nodejs-alb"
  }

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "nodejs-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id

  health_check {
    path                = "/"
    port                = 3000
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "nodejs-tg"
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.application.id
  port             = 3000
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}
