output "organization_id" {
  description = "The ID of the organization"
  value       = module.organizations.organization_id
}

output "organization_arn" {
  description = "The ARN of the organization"
  value       = module.organizations.organization_arn
}

output "accounts" {
  description = "Map of created organization accounts"
  value       = module.organizations.accounts
}
