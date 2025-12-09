# Bucket básico
resource "aws_s3_bucket" "app_data" {
  bucket = "my-app-data-bucket"
  
  tags = {
    Name        = "App Data"
    Environment = "dev"
  }
}

# Configurar versionado
resource "aws_s3_bucket_versioning" "app_data" {
  bucket = aws_s3_bucket.app_data.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# Subir un archivo
resource "aws_s3_object" "config_file" {
  bucket       = aws_s3_bucket.app_data.id
  key          = "config/app.json"
  source       = "${path.module}/files/app.json"
  content_type = "application/json"
  
  etag = filemd5("${path.module}/files/app.json")
}

# Subir contenido directamente
resource "aws_s3_object" "readme" {
  bucket  = aws_s3_bucket.app_data.id
  key     = "README.md"
  content = <<-EOT
    # My Application
    
    This bucket contains application data.
  EOT
  
  content_type = "text/markdown"
}