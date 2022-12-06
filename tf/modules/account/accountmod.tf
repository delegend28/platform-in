resource "vault_generic_secret" "account_mod" {
  provider = vault.vault_dev
  path     = "secret/development/account"

  data_json = jsonencode({
    db_user =   var.db_user_acc
    db_password = var.db_password_acc
  })
}

resource "vault_policy" "account_mod" {
  provider = vault.vault_dev
  name = "${var.service}-${var.environ}"
  #name     = "var.policy_name_acc"

  policy = <<EOT

path "secret/data/development/account" {
    capabilities = ["list", "read"]
}

EOT
}

resource "vault_generic_endpoint" "account_mod" {
  provider             = vault.vault_dev
  depends_on           = [vault_auth_backend.userpass_dev]
  path                 = "auth/userpass/users/account-development"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["data.vault_policy.account_mod.name"]
    password = var.acct_policy_passwd
  })
}
resource "docker_container" "account_mod" {
  image = var.docker_container_acc_image
  name  = var.docker_container_acc_name

  env = [
    "VAULT_ADDR=var.VAULT_ADDR_ACC",
    "VAULT_USERNAME=var.VAULT_USERNAME_ACC",
    "VAULT_PASSWORD=var.VAULT_PASSWORD_ACC",
    "ENVIRONMENT=${local.environ}"
  ]

  networks_advanced {
    name = "vagrant_${local.environ}"
  }

  lifecycle {
    ignore_changes = all
  }
}
