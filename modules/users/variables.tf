variable "name" {
  description = "The name of the IAM user"
  type        = string
}

variable "pgp_key" {
  description = "PGP key for encrypting password and secret access key"
  type        = string
}

variable "groups" {
  description = "List of IAM groups to add the user to"
  type        = list(string)
  default     = []
}
