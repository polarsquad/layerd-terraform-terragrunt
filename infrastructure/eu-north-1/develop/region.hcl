dependency "layer_0" {
  config_path = "${get_repo_root()}/infrastructure/global/layer_0"
}

generate "account_providers" {
  path      = "account_providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "eu-north-1"
  assume_role {
    role_arn = "arn:aws:iam::${dependency.layer_0.outputs.accounts["develop"].id}:role/Admin"
  }
}
EOF
}
