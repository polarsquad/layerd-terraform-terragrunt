module "users_self_manage" {
  source = "../../modules/users_self_manage"

  count = var.enable_users_self_manage ? 1 : 0
}

module "developer-role" {
  source         = "../../modules/developer-role"
  
  count          = var.enable_developer_role ? 1 : 0
  trusted_entity = var.developer_role_trusted_entity
}

module "developer_groups" {
  for_each = var.enable_developer_groups ? var.developer_groups : {}
  source   = "../../modules/developer-group"

  group_name       = each.value.group_name
  assume_role_arns = each.value.assume_role_arns
}

module "users" {
  for_each = var.users
  source   = "../../modules/users"

  name    = each.value.name
  pgp_key = each.value.pgp_key
  groups  = each.value.groups
}
