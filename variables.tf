variable "devops_management" {
  type        = list(string)
  default     = []
  description = "List of DevOpsManagement users"
}
variable "external_zone" {
  type        = string
  default     = ""
  description = "External zone"
}
variable "delegation" {
  type        = map(list(string))
  default     = {}
  description = "External delegation"
}

variable "developers" {
  type        = list(string)
  default     = []
  description = "List of developers roles"
}

variable "production_account" {
  type        = bool
  description = "production account"
  default     = false
}
