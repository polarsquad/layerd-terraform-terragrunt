resource "aws_organizations_organization" "organization" {
}

resource "aws_organizations_account" "accounts" {
  for_each = var.accounts

  name                       = each.value.name
  email                      = each.value.email
  iam_user_access_to_billing = each.value.iam_user_access_to_billing
  parent_id                  = each.value.parent_id
  role_name                  = each.value.role_name
  tags                       = each.value.tags

  depends_on = [aws_organizations_organization.organization]
}
