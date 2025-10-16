resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "${var.project}-db-credentials-${random_id.suffix.hex}"
  description = "RDS database credentials for ${var.project}"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}
