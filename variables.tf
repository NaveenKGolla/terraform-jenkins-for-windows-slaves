# Project Name

variable "project_name" {
  type = string
  description = "Name of the project"
}


# security_group_variables: Jenkins_Slave_windows

variable "jsw_additional_sg_tags" {
  default     = {}
  description = "A map of Additional resource tags to add to jenkins slave windows server"
  type        = map(string)
}



# security_group_variables: jenkins_master

variable "jm_additional_sg_tags" {
  default     = {}
  description = "A map of Additional resource tags to add to jenkins master"
  type        = map(string)
}

variable "sg_cidr_block" {
  type = list(string)
  description = "jenkins master and slaves- cidr range blocks"
}


# Jenkins master Load Balancer
variable "jm_lb_additional_tags" {
  default     = {}
  description = "A map of Additional resource tags to add to jenkins master"
  type        = map(string)
}



# jenkins_master_variables

variable "jm_admin_password" {
  type = string
  description = "Jenkins master Admin Password"
}

variable "jm_ami_id" {
  type = string
  description = "The id of the machine image (AMI) to use for the server by region"
  default = "ami-00ee4df451840fa9d"       // for ubuntu and for windows - ami-000b6e3a1a8493a2f
}

variable "jm_instance_type" {
  type = string
  description = "The type of the instance"
}

variable "jm_key_name" {
  type = string
  description = "The name of the key to use for the server"
}

variable "jm_subnet_id" {
  type = string
  description = "The id of the Subnet to use for the server"
}

variable "jm_volume_size" {
  type = number
  description = "Size of the instance"
}

variable "jm_tags" {
  type = map
  description = "A map of tags to add to the instance"
  default     = {}
}

variable "jm_additional_tags" {
  default     = {}
  description = "A map of Additional resource tags to add to jenkins master"
  type        = map(string)
}





# jenkins_slave_windows_aws_launch_configuration_variables

variable "jsw_alc_name_prefix" {
  type = string
  description = "Name prefix to be used to derive name to Launch Configuration."
}

variable "jsw_ami_id" {
  type = string
  description = "The id of the image (AMI) to use for LC"
  default = "ami-00ee4df451840fa9d"
}

variable "jsw_alc_instance_type" {
  type = string
  description = "The type of the instance"
}

variable "jsw_alc_key_name" {
  type = string
  description = "The name of the key to use for the server"
}

variable "jsw_alc_volume_size" {
  type = number
  description = "Size of the instance"
}






# jenkins_slave_windows_aws_autoscaling_group_variables

variable "jsw_asg_name" {
  type = string
  description = "The id of the machine image (AMI) to use for the server by region"
}

variable "jsw_asg_min_size" {
  type = number
  description = "The minimum capacity of the Auto Scaling Group"
}

variable "jsw_asg_max_size" {
  type = number
  description = "The maximum capacity of the Auto Scaling Group"
}

variable "jsw_asg_desired_capacity" {
  type = number
  description = "The desired capacity of the Auto Scaling Group"
}

variable "jsw_asg_health_check_type" {
  type = string
  description = "The type of health check"
}

variable "jsw_asg_vpc_zone_identifier" {
  type = list(string)
  description = "The group of subnets where ASG belong to"
  default     = []
}

variable "jsw_additional_tags" {
  type = list(any)
  description = "A map of tags to add to all the instances"
  default     = []
}
