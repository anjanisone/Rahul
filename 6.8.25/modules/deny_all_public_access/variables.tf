variable "subnet_ids" {
  description = "List of existing subnet IDs to apply deny-all route table"
  type        = list(string)
}

variable "resource_group_name" {
  description = "Resource group where the route table will be created"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
  default     = "deny-all-rt"
}
