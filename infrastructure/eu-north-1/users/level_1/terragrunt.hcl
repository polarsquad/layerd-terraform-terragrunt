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

  users = {
    john_doe = {
      name    = "john.doe"
      pgp_key = "mQENBGlwqHoBCADWUG0IcAYcYex+cJ8nVsfNdCQ82EzoaELFzLeILqYRcIAJtSP82JXPrnhOujAE3Uf3skBt63MY/d4vQCvJBuC96C7JnZIe27dDvgcOAGlNEJqM6ognDM+OtgY9ySlc4B1gWGhGdcWe14h5Qfj9aa3sC4QiRoGDgAKKwajglbpLdD7nwI/1ko7kaNMZvf2o2Kww1lvhVMjXIWH3xXrOIs7TCkV+O6k9As2s7mLHDx1Tkfumngcdu2RftUExCQXq6yUBEP53mcQWEWycio4KQvLZtDKpxxDBiQmNxcpJAB8jZroqBEvn2TZu8/H0SMvvuh2HHSEanwTTBklfd7H3vgsxABEBAAG0H0pvaG4gRG9lIDxqb2huLmRvZUBleGFtcGxlLmNvbT6JAVgEEwEKAEIWIQRHL5f3N2cTQziylbthVQt4TBNGigUCaXCoegMbLwQFCQB2pwAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQYVULeEwTRooLSwf+NIT2vRcTT8He+iTanNy/p9pvS2Jr4VgmyMHzqC6Fr3Kxpcez1kLQkyUpckh1yWNup4j1CaQLPfjYPHY04nXh0fb7pGGv8HOlWRWxCiflX0IeNFCnHZZqT3crjS50zF6FUJTRIoLmN4TpLy/i5kSWXOYyv1bVXVl7UlKPouYdyewmjB/4zepCTV3RM7WG+CpnVXkJbTkKRX0evQD8N0G6Opn582DM9tU//dioKmeo+i7WvyyDfzp//wo3lEX5+fCKg53kjOt+N5mh/A87Z/EJXRfkLeqlarQar9zRIUsyVCPZHc4ZqVfUuUKptX+CLZBvFSiMewI5/blK7Qz7CPJ4VQ=="
      groups  = ["SelfManaging", "DevelopersDevelop"]
    }
    jane_smith = {
      name    = "jane.smith"
      pgp_key = "mQENBGlwqHoBCADWUG0IcAYcYex+cJ8nVsfNdCQ82EzoaELFzLeILqYRcIAJtSP82JXPrnhOujAE3Uf3skBt63MY/d4vQCvJBuC96C7JnZIe27dDvgcOAGlNEJqM6ognDM+OtgY9ySlc4B1gWGhGdcWe14h5Qfj9aa3sC4QiRoGDgAKKwajglbpLdD7nwI/1ko7kaNMZvf2o2Kww1lvhVMjXIWH3xXrOIs7TCkV+O6k9As2s7mLHDx1Tkfumngcdu2RftUExCQXq6yUBEP53mcQWEWycio4KQvLZtDKpxxDBiQmNxcpJAB8jZroqBEvn2TZu8/H0SMvvuh2HHSEanwTTBklfd7H3vgsxABEBAAG0H0pvaG4gRG9lIDxqb2huLmRvZUBleGFtcGxlLmNvbT6JAVgEEwEKAEIWIQRHL5f3N2cTQziylbthVQt4TBNGigUCaXCoegMbLwQFCQB2pwAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQYVULeEwTRooLSwf+NIT2vRcTT8He+iTanNy/p9pvS2Jr4VgmyMHzqC6Fr3Kxpcez1kLQkyUpckh1yWNup4j1CaQLPfjYPHY04nXh0fb7pGGv8HOlWRWxCiflX0IeNFCnHZZqT3crjS50zF6FUJTRIoLmN4TpLy/i5kSWXOYyv1bVXVl7UlKPouYdyewmjB/4zepCTV3RM7WG+CpnVXkJbTkKRX0evQD8N0G6Opn582DM9tU//dioKmeo+i7WvyyDfzp//wo3lEX5+fCKg53kjOt+N5mh/A87Z/EJXRfkLeqlarQar9zRIUsyVCPZHc4ZqVfUuUKptX+CLZBvFSiMewI5/blK7Qz7CPJ4VQ=="
      groups  = ["SelfManaging", "DevelopersProduction"]
    }
  }
}