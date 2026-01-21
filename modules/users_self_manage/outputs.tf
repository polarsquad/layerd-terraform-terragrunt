output "self_managing_group_name" {
  description = "The name of the SelfManaging IAM group"
  value       = aws_iam_group.self_managing.name
}

output "self_managing_group_arn" {
  description = "The ARN of the SelfManaging IAM group"
  value       = aws_iam_group.self_managing.arn
}

output "self_managing_group_id" {
  description = "The ID of the SelfManaging IAM group"
  value       = aws_iam_group.self_managing.id
}

output "self_manage_vmfa_policy_arn" {
  description = "The ARN of the SelfManageVMFA IAM policy"
  value       = aws_iam_policy.self_manage_vmfa.arn
}

output "self_manage_vmfa_policy_id" {
  description = "The ID of the SelfManageVMFA IAM policy"
  value       = aws_iam_policy.self_manage_vmfa.id
}

output "self_manage_vmfa_policy_name" {
  description = "The name of the SelfManageVMFA IAM policy"
  value       = aws_iam_policy.self_manage_vmfa.name
}

output "attached_policies" {
  description = "List of policy ARNs attached to the SelfManaging group"
  value = [
    aws_iam_group_policy_attachment.iam_read_only_access.policy_arn,
    aws_iam_group_policy_attachment.iam_self_manage_service_specific_credentials.policy_arn,
    aws_iam_group_policy_attachment.iam_user_change_password.policy_arn,
    aws_iam_group_policy_attachment.self_manage_vmfa.policy_arn
  ]
}
