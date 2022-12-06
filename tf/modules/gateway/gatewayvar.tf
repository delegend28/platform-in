variable "service" {
  type = string
}

variable "environ" {
  description = "application envronment"
  type = string
}

variable "db_user_gw" {
  description = "db -user id"
  type = string
}

variable "db_password_gw" {
  description = "db -user password"
  type = string
  sensitive = true
}

variable "password_gw" {
  description = "account policy password"
  type = string
  sensitive = true
}

variable "docker_container_gw_name" {
  type = string
}

variable "docker_container_gw_image" {
  type = string
}

variable "VAULT_ADDR_gw" {
  type = string
}

variable "VAULT_USERNAME_gw" {
  description = "vault username"
  type = string
}

variable "VAULT_PASSWORD_gw" {
  description = "vault password"
  type = string
  sensitive = true
}
