variable "name" {
  type        = string
  description = "Name prefix for all resources"
}

variable "location" {
  type        = string
}

variable "resource_group" {
  type        = string
}

variable "vnet_cidr" {
  type = list(string)
}

variable "public_subnets" {
  type = list(object({
    name = string
    cidr = string
  }))
}

variable "private_subnets" {
  type = list(object({
    name = string
    cidr = string
  }))
}