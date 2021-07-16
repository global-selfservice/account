data "vault_generic_secret" "azuread" {
  path = "secret/devops/azuread"
}

locals {
  azuread_appid  = data.vault_generic_secret.azuread.data["application-id"]
  azuread_secret = data.vault_generic_secret.azuread.data["secret-id"]
}
