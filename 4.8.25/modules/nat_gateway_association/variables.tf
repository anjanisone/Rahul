variable "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  type        = string
}

variable "subnet_ids" {
  description = "Map of subnet name to subnet ID for association"
  type        = map(string)
}
