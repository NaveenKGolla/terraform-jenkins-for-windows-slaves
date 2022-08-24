# Security Group:
resource "aws_security_group" "jenkins_master" {
  name        = "${var.project_name}-jenkins_master-sg"
  description = "Jenkins Master SG: created by Terraform"
  vpc_id      = data.aws_vpc.spoke_vpc.id
  tags = merge(
    var.jsw_additional_sg_tags,
    {
      Name = "${var.project_name}-jenkins-master-sg"
    },
  )

  # ssh
  ingress{
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = var.sg_cidr_block
    description       = "ssh to jenkins_master"
  }

  # web
  ingress{
    from_port         = 8080
    to_port           = 8080
    protocol          = "tcp"
    cidr_blocks       = var.sg_cidr_block
    description       = "jenkins master web"
  }

  # JNLP
  ingress{
    from_port         = 33453
    to_port           = 33453
    protocol          = "tcp"
    cidr_blocks       = var.sg_cidr_block
    description       = "jenkins master JNLP Connection"
  }

  # Egress rules
  egress{
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = var.sg_cidr_block
    description       = "allow jenkins master to reach other nodes"
  }

}
