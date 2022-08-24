# Security Group:
resource "aws_security_group" "jenkins_slave_windows" {
  name        = "${var.project_name}-jenkins_slave_windows-sg"
  description = "Jenkins Slave Windows SG: created by Terraform"
  vpc_id      = data.aws_vpc.spoke_vpc.id
  tags = merge(
    var.jm_additional_sg_tags,
    {
      Name = "${var.project_name}-jenkins-slave-windows-sg"
    },
  )

  # web
  ingress{
    from_port         = 8080
    to_port           = 8080
    protocol          = "tcp"
    cidr_blocks       = var.sg_cidr_block
    description       = "jenkins slave windows web"
  }

  # RDP
  ingress{
    from_port         = 3389
    to_port           = 3389
    protocol          = "tcp"
    cidr_blocks       = var.sg_cidr_block
    description       = "jenkins Slave RDP Connection"
  }

  # Egress rules
  egress{
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = var.sg_cidr_block
    description       = "allow jenkins slave windows to reach from master"
  }

}
