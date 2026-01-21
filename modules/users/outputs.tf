output "summary" {
  description = "Summary of the IAM user credentials (encrypted)"
  value = {
    name              = var.name
    password          = aws_iam_user_login_profile.this.encrypted_password
    access_key_id     = aws_iam_access_key.this.id
    secret_access_key = aws_iam_access_key.this.encrypted_secret
  }
  sensitive = true
}

output "user_name" {
  description = "The name of the IAM user"
  value       = aws_iam_user.this.name
}

output "user_arn" {
  description = "The ARN of the IAM user"
  value       = aws_iam_user.this.arn
}

output "user_unique_id" {
  description = "The unique ID of the IAM user"
  value       = aws_iam_user.this.unique_id
}

output "access_key_id" {
  description = "The access key ID"
  value       = aws_iam_access_key.this.id
}

output "encrypted_password" {
  description = "The encrypted password for the user"
  value       = aws_iam_user_login_profile.this.encrypted_password
  sensitive   = true
}

output "encrypted_secret_access_key" {
  description = "The encrypted secret access key"
  value       = aws_iam_access_key.this.encrypted_secret
  sensitive   = true
}
