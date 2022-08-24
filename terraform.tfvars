# Project Name variable
project_name               = "Olympius"

# security_group_values: Jenkins_Slave_windows
jsw_additional_sg_tags     = {}

# security_group_values: jenkins_master
jm_additional_sg_tags      = {}

sg_cidr_block              = ["10.120.176.0/24"]

# Jenkins master Load Balancer
jm_lb_additional_tags      = {}


# jenkins_master_aws_instance_values
jm_admin_password           = "mysupersecretpassword"
jm_ami_id                   = "ami-00ee4df451840hvqhjbhj"
jm_instance_type          	= "m5.large"
jm_key_name               	= "BuildServer"
jm_subnet_id              	= "subnet-0d2110f2e47hbvjhbj"
jm_additional_tags          = {}
jm_volume_size              = 100


# jenkins_slave_windows_aws_launch_configuration_values
jsw_alc_name_prefix                 = "jenkins-slave-"
jsw_ami_id                          = "ami-000b6e3a1a84hnbjwkjn"
jsw_alc_instance_type               = "m5.large"
jsw_alc_key_name                    = "BuildServer"
jsw_alc_volume_size                 = 100
 

# jenkins_slave_windows_aws_autoscaling_group_values
jsw_asg_name                      = "jenkins-slave-windows"
jsw_asg_min_size                  = 1
jsw_asg_max_size                  = 2
jsw_asg_desired_capacity          = 2
jsw_asg_health_check_type         = "EC2"
jsw_asg_vpc_zone_identifier       = ["subnet-0d2110f2e47dnlknwlk", "subnet-09a9c13c51dbdjbkj"]
jsw_additional_tags =  [
      {
        "key"                 = "slave-1"
        "value"               = "jenkins_slave_windows-1"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "slave-2"
        "value"               = "jenkins_slave_windows-2"
        "propagate_at_launch" = true
      }
]