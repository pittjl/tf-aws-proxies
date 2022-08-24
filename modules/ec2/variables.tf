variable "namespace" {
  type = string
}

variable "vpc" {
  type = any
}

variable key_name {
  type = string
}

variable "sg_pub_id" {
  type = any
}

variable "ip_address" {
  type = string
}

variable "instance_count" {
  type = number
}
