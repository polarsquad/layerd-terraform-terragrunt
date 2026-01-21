include "root" {
  path = find_in_parent_folders("root.hcl")
}
include "region" {
  path = find_in_parent_folders("region.hcl")
}
include "global_dependencies" {
  path = find_in_parent_folders("global_dependencies.hcl")
} 

terraform {
  source = "${get_repo_root()}//levels/layer_1"
}

inputs = {
  enable_developer_role = true
  developer_role_trusted_entity = "arn:aws:iam::${dependency.layer_0.outputs.accounts["develop"].id}:root"
}