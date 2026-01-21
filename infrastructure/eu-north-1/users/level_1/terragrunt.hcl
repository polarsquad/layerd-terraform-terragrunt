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
}