variable "subscription_id" {
  type      = string
  sensitive = true
}

variable "tenant_id" {
  type      = string
  sensitive = true
}

variable "acr_name" {
  type    = string
  default = "andreikubetestassignmentacr"
}