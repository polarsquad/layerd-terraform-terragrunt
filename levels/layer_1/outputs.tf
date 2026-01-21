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
