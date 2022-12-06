resource "vault_generic_secret" "account_development" {
  provider = vault.vault_dev
  path     = "secret/development/account"

  data_json = jsonencode({
    db_user =   var.db_user[0]
    db_password = var.db_password[0]
  })
}

resource "vault_policy" "account_development" {
  provider = vault.vault_dev
  name     = "account-${local.environ}"

  policy = <<EOT

path "secret/data/development/account" {
    capabilities = ["list", "read"]
}

EOT
}

resource "vault_generic_endpoint" "account_development" {
  provider             = vault.vault_dev
  depends_on           = [vault_auth_backend.userpass_dev]
  path                 = "auth/userpass/users/account-development"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["data.vault_policy.account_development.name"]
    password = var.password[0]
  })
}
resource "docker_container" "account_development" {
  image = "form3tech-oss/platformtest-account"
  name  = "account_development"

  env = [
    "VAULT_ADDR=http://vault-development:8200",
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
