output "users_self_manage" {
  description = "Outputs from the users self manage module"
  value = var.enable_users_self_manage ? {
    group_name        = module.users_self_manage[0].self_managing_group_name
    group_arn         = module.users_self_manage[0].self_managing_group_arn
    group_id          = module.users_self_manage[0].self_managing_group_id
    vmfa_policy_arn   = module.users_self_manage[0].self_manage_vmfa_policy_arn
    attached_policies = module.users_self_manage[0].attached_policies
  } : null
}

output "developer_role" {
  description = "Outputs from the developer role module"
  value = var.enable_developer_role ? {
    role_arn  = module.developer-role[0].role_arn
    role_name = module.developer-role[0].role_name
    role_id   = module.developer-role[0].role_id
  } : null
}

output "developer_groups" {
  description = "Outputs from developer groups"
  value = var.enable_developer_groups ? {
    for k, v in module.developer_groups : k => {
      group_name = v.group_name
      group_arn  = v.group_arn
      group_id   = v.group_id
      policy_arn = v.policy_arn
    }
  } : null
}

output "users" {
  description = "Outputs from IAM users"
  value = length(var.users) > 0 ? {
    for k, v in module.users : k => {
      user_name      = v.user_name
      user_arn       = v.user_arn
      user_unique_id = v.user_unique_id
      access_key_id  = v.access_key_id
    }
  } : null
  sensitive = true
}

output "users_credentials" {
  description = "Encrypted credentials for IAM users"
  value = length(var.users) > 0 ? {
    for k, v in module.users : k => v.summary
  } : null
  sensitive = true
}
