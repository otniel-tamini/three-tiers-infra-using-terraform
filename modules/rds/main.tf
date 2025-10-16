# Data source to read secret value from AWS Secrets Manager
data "aws_secretsmanager_secret_version" "db_credentials_version" {
  # Pass the ARN from the secrets module output in main.tf
  secret_id = var.db_secret_arn
}
resource "aws_security_group" "rds_sg" {
  name        = "${var.project}-rds-sg"
  description = "Allow DB access from EC2/ASG"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow DB access"
    from_port        = var.db_port
    to_port          = var.db_port
    protocol         = "tcp"
    security_groups  = [var.ec2_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-rds-sg"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.project}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project}-rds-subnet-group"
  }
}

resource "aws_db_instance" "rds" {
  identifier              = "${var.project}-db"
  engine                  = var.db_engine
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_storage
  username                = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_version.secret_string)["username"]
  password                = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_version.secret_string)["password"]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = var.multi_az
  storage_encrypted       = true

  tags = {
    Name = "${var.project}-rds"
  }
}