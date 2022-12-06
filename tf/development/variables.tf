variable "vault_token" {
  type = string
  sensitive = true
}

variable "vault_address" {
  type = string
  #default = "http://localhost:8201"
}

variable "environ" {
  description = "application envronment"
  type = string
}

variable "db_user" {
  description = "db -user id"
  type = list
}

variable "db_password" {
  description = "db -user password"
  type = list
  sensitive = true
}

variable "password" {
  description = "account policy password"
  type = list
  sensitive = true
}

variable "VAULT_USERNAME" {
  description = "vault username"
  type = list
}

variable "VAULT_PASSWORD" {
  description = "vault password"
  type = list
  sensitive = true
}
