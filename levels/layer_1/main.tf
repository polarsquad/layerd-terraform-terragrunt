module "users_self_manage" {
  source = "../../modules/users_self_manage"

  count = var.enable_users_self_manage ? 1 : 0
}