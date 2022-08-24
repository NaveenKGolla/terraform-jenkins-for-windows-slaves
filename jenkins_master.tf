# userdata for jenkins master
data "template_file" "jenkins_master" {
  template = "${file("scripts/jenkins_master.sh")}"
  
  vars = {
    jenkins_admin_password = "${var.jm_admin_password}"
  }
}

resource "aws_instance" "jenkins_master" {
  ami                    		= var.jm_ami_id
  instance_type          		= var.jm_instance_type
  key_name               		= var.jm_key_name
  subnet_id              		= var.jm_subnet_id
  vpc_security_group_ids 		= [data.aws_security_groups.vpc_default_sg.ids[0], aws_security_group.jenkins_master.id]
  user_data              		= data.template_file.jenkins_master.rendered
  
  tags = merge(
    var.jm_additional_tags,
    {
      Name = "${var.project_name}-jenkins-master-server"
    },
  )

  root_block_device {
    delete_on_termination = false
    volume_size = var.jm_volume_size
  }
  
  depends_on = [
    aws_security_group.jenkins_master
  ]

}



resource "aws_lb" "jenkins_master_lb" {
  name               = "${var.project_name}-jenkins-master-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [data.aws_security_groups.vpc_default_sg.ids[0], aws_security_group.jenkins_master.id]
#   subnets            = [for subnet in aws_subnets.vpc_subnets : subnet.id]
  subnets            = var.jsw_asg_vpc_zone_identifier
  
  enable_deletion_protection = false

  tags = merge(
    var.jm_lb_additional_tags,
    {
      Name = "${var.project_name}-jenkins-master-lb"
    },
  )

  depends_on = [
    aws_security_group.jenkins_master
  ]

}


resource "aws_lb_target_group" "jenkins-master-lb-TG" {
  name         = "${var.project_name}-jenkins-master-lb-TG"
  port         = 8080
  protocol     = "HTTP"
  vpc_id       = data.aws_vpc.spoke_vpc.id
  health_check {
    path       = "/login"
  }
}


resource "aws_lb_target_group_attachment" "jenkins-master-lb-TGA" {
  target_group_arn = aws_lb_target_group.jenkins-master-lb-TG.arn
  target_id        = aws_instance.jenkins_master.id
  port             = 8080
}


resource "aws_lb_listener" "jenkins-master" {
  load_balancer_arn = aws_lb.jenkins_master_lb.arn
  port              = "8080"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins-master-lb-TG.arn
  }
}
