include "root" {
  path = find_in_parent_folders("root.hcl")
}
include "region" {
  path = find_in_parent_folders("region.hcl")
}

terraform {
  source = "${get_repo_root()}//levels/layer_0"
}

inputs = {
  accounts = {
    "users" = {
      name              = "users"
      email             = "camilo+awsusers@polarsquad.com"
      close_on_deletion = true
      tags = {
        "Environment" = "users"
      }
    }
    "develop" = {
      name              = "develop"
      email             = "camilo+awsdevelop@polarsquad.com"
      close_on_deletion = true
      tags = {
        "Environment" = "develop"
      }
    }
    "production" = {
      name              = "production"
      email             = "camilo+awsproduction@polarsquad.com"
      close_on_deletion = true
      tags = {
        "Environment" = "production"
      }
    }
  }
}