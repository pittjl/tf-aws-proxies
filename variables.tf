variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  default     = "TT-TEST"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-west-2"
  type        = string
}

variable "ip_address" {
  description = "External IP address"
  type = string
}

variable "proxy_port" {
  description = "Proxy port for incoming requests"
  default     = 8888
}