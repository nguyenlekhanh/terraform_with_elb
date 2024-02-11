variable "prefix" {
  default = "terraform"
}

variable "project" {
  default = "devops-app"
}

variable "contact" {
  default = "nguyenlekhanh811@gmail.com"
}

variable "db_username" {
  description = "Username for the RDS Postgres instance"
}

variable "db_password" {
  description = "Password for the RDS postgres instance"
}

variable "bastion_key_name" {
  default = "key_pair_name_from_aws"
}
