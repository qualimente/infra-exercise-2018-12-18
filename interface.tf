variable "name" {
  type = "string"
}

variable "vpc_id" {
  type    = "string"
  default = "vpc-58a29221"
}

variable "region" {
  default = "us-east-1"
  type    = "string"
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = "list"

  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
}

variable "db_pass" {
  default     = "mypass27"
  description = "Password to use for DB"
}


// Output Location of ELB and App Server - START

output "lb.web.dns_name" {
  value = "${aws_elb.web.dns_name}"
}

output "app.web.dns_name" {
  value = "${element(aws_instance.app.*.public_dns, 0)}"
}

output "app.asg.name" {
  value = "${module.asg.this_autoscaling_group_name}"
}

output "app.asg.launch_configuration_name" {
  value = "${module.asg.this_launch_configuration_name}"
}

// Output Location of ELB and App Server - END
