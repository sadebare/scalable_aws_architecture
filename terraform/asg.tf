# Auto Scaling Group
resource "aws_autoscaling_group" "nginx_asg" {
  launch_configuration = aws_launch_configuration.nginx_launch_config.id
  vpc_zone_identifier  = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  health_check_type    = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "Nginx Server"
    propagate_at_launch = true
  }

  target_group_arns = [aws_lb_target_group.nginx_tg.arn]
  
  lifecycle {
    create_before_destroy = true
  }
}


# Auto Scaling Policies
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.nginx_asg.name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale-in-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.nginx_asg.name
}