variable "project" {
  type = string
}

variable "origin_domain" {
  description = "Domain name of the origin (S3 bucket or ALB DNS)"
  type        = string
}

variable "origin_type" {
  description = "Type of origin: s3 or alb"
  type        = string
}