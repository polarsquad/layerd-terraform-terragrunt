# Layered Terraform-Terragrunt Infrastructure

A multi-account AWS infrastructure management system using Terraform and Terragrunt with a layered architecture approach.

## Project Structure

```
.
├── infrastructure/          # Terragrunt configurations by region/environment
│   ├── root.hcl            # Root configuration with remote state and providers
│   ├── global/             # Global resources (AWS Organizations)
│   │   └── layer_0/        # Organization and accounts
│   ├── eu-north-1/         # Regional configurations
│       ├── users/          # Users account resources
│       ├── develop/        # Development account resources
│       └── production/     # Production account resources
│   
│
├── levels/                 # Terraform module layers
│   ├── layer_0/           # AWS Organizations and accounts
│   └── layer_1/           # IAM resources (users, groups, roles)
│
└── modules/               # Reusable Terraform modules
    ├── organizations/     # AWS Organizations and accounts
    ├── users_self_manage/ # Self-managing IAM group
    ├── developer-role/    # Assumable Developer role
    ├── developer-group/   # IAM group for role assumption
    └── users/            # IAM users with PGP-encrypted credentials
```

## Features

### Layer 0: Organizations
- **Dynamic Account Creation**: Create multiple AWS accounts using a map variable
- **Organization Management**: Centralized AWS Organization setup
- **Account Outputs**: Automatic output of account IDs and ARNs for cross-account access

### Layer 1: IAM Management
- **Comprehensive IAM**: Manages all IAM resources including policies, roles, users, and groups
- **Dynamic Users**: Create multiple IAM users with PGP-encrypted credentials
- **Developer Groups**: Multiple developer groups with custom role assumption policies
- **Self-Managing Groups**: IAM groups with self-service MFA and credential management
- **Cross-Account Roles**: Developer roles that can be assumed across accounts
- **Policy Management**: Custom IAM policies and policy attachments
- **Permission Boundaries**: Enforce security boundaries for users and roles

### Layer 2: Network Infrastructure (Planned)
- **VPC Management**: Create and manage VPCs across multiple accounts and regions
- **Subnet Configuration**: Public, private, and database subnets with proper CIDR management
- **Network Connectivity**: VPC peering, Transit Gateway, and VPN configurations
- **Security Groups**: Centralized security group management
- **Route Tables**: Routing configuration for multi-tier architectures

### Layer 3: Workload Resources (Planned)
- **Container Orchestration**: EKS and ECS cluster management
- **Serverless**: Lambda functions and API Gateway configurations
- **Compute**: EC2 instances and Auto Scaling Groups
- **Databases**: RDS, DynamoDB, and other database services
- **Storage**: S3 buckets, EFS, and storage management
- **Application Load Balancers**: ALB and NLB configurations

### Key Capabilities
- **Module Composition**: Layers wrap modules for reusable infrastructure patterns
- **Conditional Resources**: Boolean flags to enable/disable module features
- **Dynamic Provider Aliasing**: Automatic provider configuration for multiple accounts
- **For-Each Patterns**: Create multiple resources from map variables
- **Secure Credentials**: PGP-encrypted passwords and access keys

## Prerequisites

- Terraform >= 1.13.3
- Terragrunt >= 0.90.0
- AWS CLI configured with appropriate credentials
- GPG for PGP key generation (optional, for user credentials)

## Quick Start

### 1. Initialize Infrastructure

```bash
# Create organization and accounts (layer_0)
cd infrastructure/global/layer_0
terragrunt apply
```

### 2. Create IAM Resources

```bash
# Create IAM users and groups in the users account
cd infrastructure/eu-north-1/users/level_1
terragrunt apply
```

### 3. Apply to All Environments

```bash
# Apply all configurations at once
cd infrastructure
terragrunt run apply --all
```

## Common Commands

### Planning Changes

```bash
# Plan changes for all modules with provider caching (faster)
terragrunt run plan -a --provider-cache

# Plan specific layer
cd infrastructure/eu-north-1/users/level_1
terragrunt plan

# Plan all modules without cache
terragrunt run-all plan
```

### Applying Changes

```bash
# Apply with provider cache (recommended for faster execution)
terragrunt run apply -a --provider-cache

# Apply specific layer
terragrunt apply

# Apply all modules
terragrunt run-all apply
```

### Provider Cache Benefits

The `--provider-cache` flag:
- Shares Terraform provider binaries across all modules
- Significantly reduces init time when working with multiple modules
- Reduces network bandwidth usage
- Recommended for `run-all` operations


## Configuration Examples

### Creating AWS Accounts

In `infrastructure/global/layer_0/terragrunt.hcl`:

```hcl
inputs = {
  accounts = {
    users = {
      name  = "users"
      email = "aws-users@example.com"
      tags  = { Environment = "users" }
    }
    develop = {
      name  = "develop"
      email = "aws-develop@example.com"
      tags  = { Environment = "develop" }
    }
    production = {
      name  = "production"
      email = "aws-production@example.com"
      tags  = { Environment = "production" }
    }
  }
}
```

### Creating IAM Users and Groups

In `infrastructure/eu-north-1/users/level_1/terragrunt.hcl`:

```hcl
inputs = {
  enable_users_self_manage = true
  enable_developer_groups  = true
  
  developer_groups = {
    devs_develop = {
      group_name       = "DevelopersDevelop"
      assume_role_arns = ["arn:aws:iam::${dependency.layer_0.outputs.accounts.develop.id}:role/Developer"]
    }
    devs_production = {
      group_name       = "DevelopersProduction"
      assume_role_arns = ["arn:aws:iam::${dependency.layer_0.outputs.accounts.production.id}:role/Developer"]
    }
  }
  
  users = {
    john_doe = {
      name    = "john.doe"
      pgp_key = "keybase:johndoe"
      groups  = ["SelfManaging", "DevelopersDevelop"]
    }
  }
}
```

## PGP Key Setup

Generate a PGP key for encrypting user credentials:

```bash
# Generate a test key
gpg --batch --passphrase '' --quick-gen-key "test@example.com" rsa2048 default 90d

# Export the public key
gpg --export test@example.com | base64 -w0
```

Use in Terragrunt:
```hcl
pgp_key = "mQENBF..."  # Base64-encoded public key
# or
pgp_key = "keybase:username"
```

Decrypt password:
```bash
terragrunt output -json | jq -r '.users.value.john_doe.password' | base64 -d | gpg --decrypt
```

## Viewing Sensitive Outputs

```bash
# View all outputs including sensitive ones
terragrunt output -json

# View specific output
terragrunt output users

# Get decrypted password
terragrunt output -json | jq -r '.users_credentials.value.john_doe.password' | base64 -d | gpg --decrypt
```

## Architecture Patterns

### Module of Modules
Layers act as wrappers around base modules, providing:
- Conditional enablement via boolean flags
- Multiple resource creation via for_each
- Standardized variable interfaces
- Aggregated outputs

### Dynamic Providers
Provider aliases are generated dynamically based on created accounts:
```hcl
provider "aws" {
  alias  = "users"
  assume_role {
    role_arn = "arn:aws:iam::${account_id}:role/Admin"
  }
}
```

### Dependency Management
Terragrunt dependencies ensure correct resource creation order:
```hcl
dependency "layer_0" {
  config_path = "${get_repo_root()}/infrastructure/global/layer_0"
}
```

## Best Practices

1. **Use Layers**: Keep infrastructure organized by logical layers (0=foundation, 1=IAM, etc.)
2. **Module Composition**: Build complex infrastructure from simple, reusable modules
3. **Conditional Resources**: Use boolean flags to enable/disable features
4. **For-Each Patterns**: Use maps for creating multiple similar resources
5. **Secure Credentials**: Always use PGP encryption for sensitive credentials
6. **Remote State**: Use S3 backend with locking for team collaboration

