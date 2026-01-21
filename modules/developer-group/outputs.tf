output "group_name" {
  description = "The name of the IAM group"
  value       = aws_iam_group.this.name
}

output "group_arn" {
  description = "The ARN of the IAM group"
  value       = aws_iam_group.this.arn
}

output "group_id" {
  description = "The ID of the IAM group"
  value       = aws_iam_group.this.id
}

output "policy_arn" {
  description = "The ARN of the assume role policy"
  value       = aws_iam_policy.assume_role.arn
}
