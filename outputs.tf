##########################
# 🌐 Réseau
##########################

output "vpc_id" {
  description = "ID du VPC principal"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Liste des IDs des sous-réseaux publics"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Liste des IDs des sous-réseaux privés"
  value       = module.vpc.private_subnet_ids
}

##########################
# 🖥️ EC2 / ASG
##########################

# Si EC2 utilisé
# output "ec2_instance_ids" {
#   description = "IDs des instances EC2"
#   value       = module.ec2.instance_ids
# }

# output "ec2_private_ips" {
#   description = "Adresses IP privées des instances EC2"
#   value       = module.ec2.instance_private_ips
# }

output "asg_name" {
  description = "Nom du groupe Auto Scaling"
  value       = module.asg.asg_name
}

##########################
# 🗄️ RDS
##########################

output "rds_endpoint" {
  description = "Endpoint de la base de données RDS"
  value       = module.rds.rds_endpoint
}

##########################
# 📦 S3
##########################

output "s3_bucket_name" {
  description = "Nom du bucket S3"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN du bucket S3"
  value       = module.s3.bucket_arn
}

##########################
# 🌐 Load Balancer
##########################

output "alb_dns_name" {
  description = "DNS public de l'Application Load Balancer"
  value       = module.alb.alb_dns_name
}

##########################
# 🧊 CloudFront
##########################

output "cloudfront_domain" {
  description = "Nom de domaine de la distribution CloudFront"
  value       = module.cloudfront.cloudfront_domain
}