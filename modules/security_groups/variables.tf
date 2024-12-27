variable "environment" {
    default = "dev"
}

variable "project_name" {
  default = "test_task"
}

variable "ingress_cidr_block" {
  type = list(string)
}

variable "inrgess_protocol" {
  type = string
  default = "tcp"
}

variable "ingress_from_port" {
  default = 80
}
variable "ingress_to_port" {
  default = 80
}
variable "vpc_id" {
  
}