provider "aws" {
  region = "eu-west-1"
}

provider "vault" {}

provider "azuread" {
  client_id     = local.azuread_appid
  client_secret = local.azuread_secret
  tenant_id     = module.common.azure_tenant_id
}
