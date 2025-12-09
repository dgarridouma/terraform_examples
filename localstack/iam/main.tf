resource "aws_s3_bucket" "app_data" {
  bucket = "my-app-data-bucket"
  
  tags = {
    Name        = "App Data"
    Environment = "dev"
  }
}

# Usuario IAM
resource "aws_iam_user" "app_user" {
  name = "app-service-user"
  
  tags = {
    Department = "Engineering"
  }
}

# Política IAM
resource "aws_iam_policy" "s3_read_policy" {
  name        = "S3ReadPolicy"
  description = "Permite leer del bucket de app data"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.app_data.arn,
          "${aws_s3_bucket.app_data.arn}/*"
        ]
      }
    ]
  })
}

# Adjuntar política a usuario
resource "aws_iam_user_policy_attachment" "app_user_s3" {
  user       = aws_iam_user.app_user.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}

# Rol IAM (para Lambda, EC2, etc.)
resource "aws_iam_role" "lambda_role" {
  name = "lambda-execution-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}