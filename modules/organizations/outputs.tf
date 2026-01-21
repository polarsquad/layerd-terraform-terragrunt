output "organization_id" {
  description = "The ID of the organization"
  value       = aws_organizations_organization.organization.id
}

output "organization_arn" {
  description = "The ARN of the organization"
  value       = aws_organizations_organization.organization.arn
}

output "accounts" {
  description = "Map of created organization accounts"
  value = {
    for k, v in aws_organizations_account.accounts : k => {
      id     = v.id
      arn    = v.arn
      email  = v.email
      name   = v.name
      status = v.status
    }
  }
}
