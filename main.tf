terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket  = "s3-devops-tfstate-999"
    key     = "devops-app.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "vscode"
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    Owner       = var.contact
    ManagedBy   = "Terraform"
  }
}


data "aws_region" "current" {

}

#######################################
# Database #
#######################################
resource "aws_db_subnet_group" "main" {
  name = "${local.prefix}-main"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-main" })
  )
}

resource "aws_security_group" "rds" {
  description = "Allow access to the RDS database instance."
  name        = "${local.prefix}-rds-inbound-access"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol  = "tcp"
    from_port = 5432
    to_port   = 5432
  }

  tags = local.common_tags
}


#postgres version
#https://docs.aws.amazon.com/AmazonRDS/latest/PostgreSQLReleaseNotes/postgresql-release-calendar.html

# resource "aws_db_instance" "main" {
#   identifier              = "${local.prefix}-db"
#   db_name                 = "recipe"
#   allocated_storage       = 20
#   storage_type            = "gp2"
#   engine                  = "postgres"
#   engine_version          = "15.5"
#   instance_class          = "db.t2.micro"
#   db_subnet_group_name    = aws_db_subnet_group.main.name
#   password                = var.db_password
#   username                = var.db_username
#   backup_retention_period = 0
#   multi_az                = false
#   skip_final_snapshot     = true
#   vpc_security_group_ids  = [aws_security_group.rds.id]

#   tags = merge(
#     local.common_tags,
#     tomap({"Name" = "${local.prefix}-main"})
#   )
# }

resource "aws_db_instance" "main" {
  identifier              = "${local.prefix}-db"
  allocated_storage       = 10
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  username                = var.db_username
  password                = var.db_password
  parameter_group_name    = "default.mysql5.7"
  db_subnet_group_name    = aws_db_subnet_group.main.name
  backup_retention_period = 0
  multi_az                = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds.id]

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-main" })
  )
}