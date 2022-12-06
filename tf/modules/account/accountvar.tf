variable "service" {
  type = string
}

variable "environ" {
  description = "application envronment"
  type = string
}

variable "db_user_acc" {
  description = "db -user id"
  type = string
}

variable "db_password_acc" {
  description = "db -user password"
  type = string
  sensitive = true
}

variable "acct_policy_passwd" {
  description = "account policy password"
  type = string
  sensitive = true
}

variable "docker_container_acc_name" {
  type = string
}

variable "docker_container_acc_image" {
  type = string
}

variable "VAULT_ADDR_ACC" {
  type = string
}

variable "VAULT_USERNAME_ACC" {
  description = "vault username"
  type = string
}

variable "VAULT_PASSWORD_ACC" {
  description = "vault password"
  type = string
  sensitive = true
}
