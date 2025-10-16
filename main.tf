# Secrets Manager module for DB credentials
module "secrets" {
  source      = "./modules/secrets"
  project     = var.project
  db_username = var.db_username
  db_password = var.db_password
}
# AWS Secrets Manager for RDS credentials
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC
module "vpc" {
  source               = "./modules/vpc"
  project              = var.project
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

# ALB
module "alb" {
  source             = "./modules/alb"
  project            = var.project
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
}

# EC2 (optionnel si ASG utilisé)
# module "ec2" {
#   source              = "./modules/ec2"
#   project             = var.project
#   vpc_id              = module.vpc.vpc_id
#   private_subnet_ids  = module.vpc.private_subnet_ids
#   alb_sg_id           = module.alb.alb_sg_id
#   ami_id              = var.ami_id
#   instance_type       = var.instance_type
#   instance_count      = 2
#   user_data           = file("${path.module}/scripts/user_data.sh")
# }

# ASG
module "asg" {
  source              = "./modules/asg"
  project             = var.project
  ami_id              = var.ami_id
  instance_type       = var.instance_type
 # user_data           = file("${path.module}/scripts/user_data.sh")
  ec2_sg_id           = module.alb.alb_sg_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  target_group_arn    = module.alb.target_group_arn
  desired_capacity    = 2
  min_size            = 2
  max_size            = 4
}

# RDS
module "rds" {
  source              = "./modules/rds"
  project             = var.project
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  ec2_sg_id           = module.alb.alb_sg_id
  db_engine           = var.db_engine
  db_instance_class   = var.db_instance_class
  db_storage          = var.db_storage
  db_port             = var.db_port
  db_username         = var.db_username
  db_password         = var.db_password
  db_secret_arn       = module.secrets.db_credentials_arn
  multi_az            = var.multi_az
}

# S3
module "s3" {
  source            = "./modules/s3"
  project           = var.project
  enable_versioning = true
}

# CloudFront
module "cloudfront" {
  source        = "./modules/cloudfront"
  project       = var.project
  origin_domain = module.s3.bucket_domain_name
  origin_type   = "s3"                  # ou "alb"
}