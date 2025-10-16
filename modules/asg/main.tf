resource "aws_launch_template" "app_lt" {
  name_prefix   = "${var.project}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  #user_data = base64encode(var.user_data)

  vpc_security_group_ids = [var.ec2_sg_id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project}-asg-instance"
    }
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                      = "${var.project}-asg"
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.private_subnet_ids
  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  health_check_type         = "EC2"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "${var.project}-asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}