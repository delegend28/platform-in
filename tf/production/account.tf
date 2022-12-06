resource "vault_generic_secret" "account_production" {
  provider = vault.vault_prod
  path     = "secret/production/account"

  data_json = jsonencode({
    db_user = var.db_user[0]
    db_password = var.db_password[0]
  })

}

resource "vault_policy" "account_production" {
  provider = vault.vault_prod
  name = "account-${local.environ}"

  policy = <<EOT

path "secret/data/production/account" {
    capabilities = ["list", "read"]
}

EOT
}

resource "vault_generic_endpoint" "account_production" {
  provider             = vault.vault_prod
  depends_on           = [vault_auth_backend.userpass_prod]
  path                 = "auth/userpass/users/account-production"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["data.vault_policy.account_production.name"]
    password = var.password[0]
  })

}

resource "docker_container" "account_production" {
  image = "form3tech-oss/platformtest-account"
  name  = "account_production"

  env = [
    "VAULT_ADDR=http://vault-production:8200",
    "VAULT_USERNAME=var.VAULT_USERNAME[0]",
    "VAULT_PASSWORD=var.VAULT_PASSWORD[0]",
    "ENVIRONMENT=${local.environ}"
  ]

  networks_advanced {
    name = "vagrant_${local.environ}"
  }

  lifecycle {
    ignore_changes = all
  }
}