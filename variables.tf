# Config
variable "global_tags" {
  type = "map"

  default = {
    Provisioner = "Terraform"
    Owner       = "First.Last@email.com"
    Stage       = "dev"
  }
}

#
variable "aws_region" {
  type    = "string"
  default = "us-west-2"
}

variable "aws_profile" {
  type    = "string"
  default = "awshonolulu"
}

# Meta
variable "service" {
  type    = "string"
  default = "rds"
}

variable "service_instance" {
  type    = "string"
  default = "demo"
}

variable "stage" {
  type    = "string"
  default = "dev"
}

variable "service_ip_whitelist" {
  type    = "list"
  default = ["0.0.0.0/0"]
}

variable "mysql_pass" {
  type = "string"
}

variable "mysql_user" {
  type    = "string"
  default = "demouser"
}

variable "mysql_dbname" {
  type    = "string"
  default = "demodb"
}

variable "mysql_port" {
  type    = "string"
  default = "3306"
}

variable "mysql_instance_type" {
  type    = "string"
  default = "db.t2.small"
}

#  VPC
variable "availability_zones" {
  description = "AWS AZs to launch servers."
  type        = "list"
  default     = ["us-west-2a", "us-west-2b"]
}

variable "vpc_cidr" {
  description = "VPC CIDR to use. Defaults to 10.0.0.0/16."
  type        = "string"
  default     = "10.0.0.0/16"
}

variable "vpc_private_subnets" {
  description = "Private subnets cidrs to create."
  type        = "list"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets cidrs to create."
  type        = "list"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_database_subnets" {
  type    = "list"
  default = ["10.0.103.0/24", "10.0.104.0/24"]
}
