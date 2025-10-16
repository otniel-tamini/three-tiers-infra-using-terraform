variable "db_secret_arn" {
  type = string
  description = "ARN of the AWS Secrets Manager secret containing DB credentials."
}
variable "project" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ec2_sg_id" {
  type = string
}

variable "db_engine" {
  type    = string
  default = "postgres"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_storage" {
  type    = number
  default = 20
}

variable "db_port" {
  type    = number
  default = 5432
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "multi_az" {
  type    = bool
  default = false
}