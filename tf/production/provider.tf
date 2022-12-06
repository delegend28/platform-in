terraform {
  required_version = ">= 1.0.7"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }

    vault = {
      version = "3.0.1"
    }
  }
}

provider "vault" {
  alias   = "vault_prod"
  address = var.vault_address
  token   = var.vault_token
}

locals {
  environ = var.environ
}

resource "vault_audit" "audit_prod" {
  provider = vault.vault_prod
  type     = "file"

  options = {
    file_path = "/vault/logs/audit"
  }
}


resource "vault_auth_backend" "userpass_prod" {
  provider = vault.vault_prod
  type     = "userpass"
}

