variable "enable_users_self_manage" {
  description = "Enable the users self manage module"
  type        = bool
  default     = false
}

variable "enable_developer_role" {
  description = "Enable the developer role module"
  type        = bool
  default     = false

}

variable "developer_role_trusted_entity" {
  description = "The ARN of the trusted entity for the developer role"
  type        = string
  default     = ""
}

variable "enable_developer_groups" {
  description = "Enable the developer groups module"
  type        = bool
  default     = false
}

variable "developer_groups" {
  description = "Map of developer groups to create"
  type = map(object({
    group_name        = string
    assume_role_arns  = list(string)
  }))
  default = {}
}
