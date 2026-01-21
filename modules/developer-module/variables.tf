variable "group_name" {
  description = "The name of the IAM group"
  type        = string
}

variable "assume_role_arns" {
  description = "List of role ARNs that the group members can assume"
  type        = list(string)
}
