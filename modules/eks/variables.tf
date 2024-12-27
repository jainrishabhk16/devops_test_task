variable "aws_region" {
  type = string

}
variable "project_name" {
  type = string
}
variable "environment" {
  default = "dev"
  type    = string
}

variable "min_size" {
  default = 2
}
variable "max_size" {
  default = 5
}

variable "desired_size" {
  default = 2
}

variable "instance_types" {
  type = list(string)
}

variable "capacity_type" {
  type = string
}

variable "device_name" {
  default = "/dev/xvda"
}

variable "volume_size" {
  default = 50
}

variable "volume_type" {
  default = "gp3"
}

variable "encrypted" {
  type    = bool
  default = true
}

variable "delete_on_termination" {
  type    = bool
  default = true
}

variable "fargate_profiles_name" {
  type    = string
  default = "monitoring"
}
variable "fargate_profiles_namespace" {
  default = "monitoring"
  type    = string
}


variable "vpc_id" {
  
}
variable "private_subnets" {
  
}