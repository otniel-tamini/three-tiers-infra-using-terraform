variable "project" {
  description = "Nom du projet"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR du VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Liste des CIDR pour les sous-réseaux publics"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Liste des CIDR pour les sous-réseaux privés"
  type        = list(string)
}