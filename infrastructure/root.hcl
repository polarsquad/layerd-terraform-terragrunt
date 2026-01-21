terraform_version_constraint  = "= 1.13.3"
terragrunt_version_constraint = "= 0.90.0"

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket       = "carp-aws-infra-state"
    key          = "${path_relative_to_include()}/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}

generate "required_providers" {
  path      = "required_providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}
EOF
}