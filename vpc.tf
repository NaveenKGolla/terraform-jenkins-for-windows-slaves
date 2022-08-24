data "aws_vpc" "spoke_vpc" {
  tags = {
    Name = "Spoke VPC(Build Automation)"
  }
}

output "vpc_id" {
  value = data.aws_vpc.spoke_vpc.id
}

data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = ["${data.aws_vpc.spoke_vpc.id}"]
    }
}

output "subnet_ids" {
  value = data.aws_subnets.vpc_subnets.ids
}

data "aws_security_groups" "vpc_default_sg" {
  filter {
    name   = "vpc-id"
    values = ["${data.aws_vpc.spoke_vpc.id}"]
    }

  filter {
    name   = "group-name"
    values = ["default"]
  }
}

output "default_sg" {
  value = data.aws_security_groups.vpc_default_sg.ids
}

