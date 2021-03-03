locals {
  configuration = read_terragrunt_config("${get_parent_terragrunt_dir()}/configuration.hcl").locals
  layout        = read_terragrunt_config("${get_parent_terragrunt_dir()}/layout.hcl").locals
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "tfstate-${local.configuration.account_id}"
    key            = "${local.layout.region}/${path_relative_to_include()}/terragrunt.tfstate"
    region         = "${local.configuration.state_region}"
    encrypt        = true
    dynamodb_table = "tgstate-locking-${local.layout.region}"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  version = "%{if local.configuration.aws_provider_version != ""}${local.configuration.aws_provider_version}%{else}no version set%{endif}"
  region  = "%{if local.layout.region != ""}${local.layout.region}%{else}no region set%{endif}"
}
EOF
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = "%{if local.configuration.terraform_version != ""}${local.configuration.terraform_version}%{else}no version set%{endif}"
}
EOF
}

