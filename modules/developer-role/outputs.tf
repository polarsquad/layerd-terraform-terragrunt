output "role_arn" {
  description = "The ARN of the Developer IAM role"
  value       = aws_iam_role.this.arn
}

output "role_name" {
  description = "The name of the Developer IAM role"
  value       = aws_iam_role.this.name
}

output "role_id" {
  description = "The ID of the Developer IAM role"
  value       = aws_iam_role.this.id
}
