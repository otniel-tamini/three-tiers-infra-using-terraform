##########################
# 🔧 Global Configuration
##########################

project     = "three-tier-app-terraform"
aws_region  = "eu-west-1"

##########################
# 🌐 Réseau (VPC & Subnets)
##########################

vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]

##########################
# 🖥️ Instances EC2 / ASG
##########################

ami_id        = "ami-0b016d1e12e0375a8" # à adapter selon ta région
instance_type = "t3.micro"

##########################
# 🗄️ Base de données RDS
##########################

db_engine         = "postgres"
db_instance_class = "db.t3.micro"
db_storage        = 20
db_port           = 5432
db_username       = "dbuser" # managed by AWS Secrets Manager
db_password       = "SuperSecurePassword123!" # managed by AWS Secrets Manager
multi_az          = false

##########################
# 🧊 CloudFront
##########################

origin_type = "s3" # ou "alb"