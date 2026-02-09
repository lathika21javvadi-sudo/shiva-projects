# Create Application Load Balancer
resource "aws_lb" "alb" {
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb_sg.id]
    subnets            = aws_subnet.public [*].id

    tags = {
        Name = "main-alb"
    }
}

# Create Target Group
resource "aws_lb_target_group" "tg" {
    port        = 80
    protocol    = "HTTP"
    vpc_id      = aws_vpc.main.id
   }

# Create ALB Listener
resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
    }
}

# Attach EC2 instances to Target Group
resource "aws_lb_target_group_attachment" "attach_lb" {
    count            = var.instance_count
   target_group_arn = aws_lb_target_group.tg.arn
target_id = aws_instance.ec2[count.index].id
    port             = 80
}