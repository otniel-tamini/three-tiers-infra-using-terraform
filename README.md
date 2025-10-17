# Three-Tier Infrastructure on AWS with Terraform

## Overview
This project provisions a complete three-tier architecture on AWS using Terraform. It includes:
- **VPC** with public and private subnets across two Availability Zones
- **Application Load Balancer (ALB)** for traffic distribution
- **Auto Scaling Group (ASG)** with EC2 instances in private subnets
- **RDS** (Relational Database Service) for backend data storage
- **S3 Bucket** for static assets and backups
- **CloudFront** for CDN and global content delivery
- **Secrets Manager** for secure storage of database credentials

## Architecture
See `architecture.md` for a detailed ASCII diagram of the infrastructure, including:
- Two Availability Zones (AZs)
- Public and private subnets
- EC2 instances in private subnets
- Connections between CloudFront, S3, ALB, EC2, RDS, and Secrets Manager

## Prerequisites
- Terraform >= 1.5.0
- AWS account and credentials
- Git

## Usage
1. Clone the repository:
   ```bash
   git clone https://github.com/otniel-tamini/three-tiers-infra-using-terraform.git
   cd three-tiers-infra-using-terraform
   ```
2. Configure your variables in `terraform.tfvars`.
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Review the plan:
   ```bash
   terraform plan
   ```
5. Apply the infrastructure:
   ```bash
   terraform apply
   ```

## Notes
- The `.terraform/` directory and state files are ignored by git (see `.gitignore`).
- Do not commit sensitive files or credentials.
- For large files, use [Git LFS](https://git-lfs.github.com/) if needed.

## License
MIT
