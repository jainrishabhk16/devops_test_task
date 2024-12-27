variable "load_balancer_type"{
    default = "application"
    description = "This is the type of load balancer we will be deploying" 
}

variable "http_target_group_name" {
    default = "http-target-group"
    description = "This is the name of the target group"
}

variable "target_group_protocol" {
    default = "HTTP"
}

variable "target_group_port" {
    default = 80
}

variable "target_group_type"  {
    default = "ip"
}

variable "alb_listener_port" {
   default = 80 
}
variable "alb_listener_protocol"{
    default = "HTTP"
}
variable "project_name" {
  type = string
}
# variable "subnets" {
  
# }
variable "public_subnets" {}
variable "vpc_id" {
  
}

variable "lb_id" {
  
}