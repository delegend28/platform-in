resource "vault_generic_secret" "payment_development" {
  provider = vault.vault_dev
  path     = "secret/development/payment"

  data_json = jsonencode({
    db_user =   var.db_user[2]
    db_password = var.db_password[2]
  })
}

resource "vault_policy" "payment_development" {
  provider = vault.vault_dev
  name     = "payment-${local.environ}"

  policy = <<EOT

path "secret/data/development/payment" {
    capabilities = ["list", "read"]
}

EOT
}

resource "vault_generic_endpoint" "payment_development" {
  provider             = vault.vault_dev
  depends_on           = [vault_auth_backend.userpass_dev]
  path                 = "auth/userpass/users/payment-development"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["data.vault_policy.payment_development.name"]
    password = var.password[2]
  })

}

resource "docker_container" "payment_development" {
  image = "form3tech-oss/platformtest-payment"
  name  = "payment_${local.environ}"

  env = [
    "VAULT_ADDR=http://vault-development:8200",
    "VAULT_USERNAME=var.VAULT_USERNAME[2]",
    "VAULT_PASSWORD=var.VAULT_PASSWORD[2]",
    "ENVIRONMENT=${local.environ}"
  ]

  networks_advanced {
    name = "vagrant_${local.environ}"
  }

  lifecycle {
    ignore_changes = all
  }
}

