##########################
# 🔧 Global Configuration
##########################

variable "project" {
  description = "three-tier-infra"
  type        = string
}

variable "aws_region" {
  description = "Région AWS à utiliser"
  type        = string
  default     = "us-east-1"
}

##########################
# 🌐 Réseau (VPC & Subnets)
##########################

variable "vpc_cidr" {
  description = "CIDR principal du VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Liste des CIDRs pour les sous-réseaux publics"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Liste des CIDRs pour les sous-réseaux privés"
  type        = list(string)
}

##########################
# 🖥️ Instances EC2 / ASG
##########################

variable "ami_id" {
  description = "AMI ID pour les instances EC2"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3.micro"
}

##########################
# 🗄️ Base de données RDS
##########################

variable "db_engine" {
  description = "Type de moteur de base de données (postgres, mysql)"
  type        = string
  default     = "postgres"
}

variable "db_instance_class" {
  description = "Type d'instance RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_storage" {
  description = "Taille du stockage RDS en Go"
  type        = number
  default     = 20
}

variable "db_port" {
  description = "Port d'écoute de la base de données"
  type        = number
  default     = 5432
}

variable "db_username" {
  description = "Nom d'utilisateur de la base de données"
  type        = string
}

variable "db_password" {
  description = "Mot de passe de la base de données"
  type        = string
  sensitive   = true
}

variable "multi_az" {
  description = "Activer le déploiement multi-AZ pour RDS"
  type        = bool
  default     = false
}

##########################
# 🧊 CloudFront
##########################

variable "origin_type" {
  description = "Type d'origine pour CloudFront (s3 ou alb)"
  type        = string
  default     = "s3"
}