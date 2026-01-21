include "root" {
  path = find_in_parent_folders("root.hcl")
}
include "region" {
  path = find_in_parent_folders("region.hcl")
}

terraform {
  source = "${get_repo_root()}//levels/layer_1"
}

inputs = {
  enable_users_self_manage = true
  enable_developer_groups  = true

  developer_groups = {
    devs_develop = {
      group_name       = "DevelopersDevelop"
      assume_role_arns = ["arn:aws:iam::${dependency.layer_0.outputs.accounts["develop"].id}:role/Developer"]
    }
    devs_production = {
      group_name       = "DevelopersProduction"
      assume_role_arns = ["arn:aws:iam::${dependency.layer_0.outputs.accounts["production"].id}:role/Developer"]
    }
  }
}