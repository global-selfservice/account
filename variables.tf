variable "devops_management" {
  type        = list(string)
  default     = []
  description = "List of DevOpsManagement users"
}

variable "dev_worker" {
  type        = list(string)
  default     = []
  description = "List of developers roles"
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

variable "production_account" {
  type        = bool
  default     = false
  description = "Production account"
}
