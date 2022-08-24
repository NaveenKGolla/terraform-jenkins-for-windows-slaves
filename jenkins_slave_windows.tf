# Setting Up Windows Slave 

data "template_file" "userdata_jenkins_slave_windows" {
  template = "${file("scripts/jenkins_slave_windows.ps1")}"

  vars = {
    region           = "us-west-2"
    node_name        = "${var.project_name}-jenkins_slave_windows"
    domain           = ""
    device_name      = "eth0"
    server_ip        = aws_instance.jenkins_master.private_ip
    jenkins_username = "admin"
    jenkins_password = "${var.jm_admin_password}"
  }
}

resource "aws_launch_configuration" "jenkins_slave_windows" {
  name_prefix                 = var.jsw_alc_name_prefix
  image_id                    = var.jsw_ami_id
  instance_type               = var.jsw_alc_instance_type
  key_name                    = var.jsw_alc_key_name
  security_groups             = [data.aws_security_groups.vpc_default_sg.ids[0], aws_security_group.jenkins_slave_windows.id]
  user_data                   = data.template_file.userdata_jenkins_slave_windows.rendered
  associate_public_ip_address = false

  root_block_device {
    delete_on_termination = true
    volume_size           = var.jsw_alc_volume_size
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "jenkins_slave_windows" {
  name                      = var.jsw_asg_name
  min_size                  = var.jsw_asg_min_size
  max_size                  = var.jsw_asg_max_size
  desired_capacity          = var.jsw_asg_desired_capacity
  health_check_type         = var.jsw_asg_health_check_type
  vpc_zone_identifier       = var.jsw_asg_vpc_zone_identifier
  launch_configuration      = aws_launch_configuration.jenkins_slave_windows.name
  tags = concat(
    [
      
    ],
    var.jsw_additional_tags,
  )
}