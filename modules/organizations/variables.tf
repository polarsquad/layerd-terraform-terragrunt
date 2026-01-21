variable "accounts" {
  description = "Map of organization accounts to create"
  type = map(object({
    name                       = string
    email                      = string
    iam_user_access_to_billing = optional(string, "ALLOW")
    parent_id                  = optional(string)
    role_name                  = optional(string, "OrganizationAccountAccessRole")
    tags                       = optional(map(string), {})
  }))
  default = {}
}
