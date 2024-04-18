variable "provider_region" {
  description = "AWS region for the provider"
  type        = string
}

variable "vpc_peering_connections" {
  description = "List of VPC peering connections to establish"
  type = list(object({
    requester_vpc_id = string
    accepter_vpc_id  = string
    requester_account_id = string
    accepter_account_id  = string
    auto_accept = bool
  }))
}
