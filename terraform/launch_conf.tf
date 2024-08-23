# Launch Configuration for Auto Scaling
resource "aws_launch_configuration" "nginx_launch_config" {
  name          = "nginx-launch-configuration"
  image_id      = var.image_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.nginx_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_rds_access_profile.name
  
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

