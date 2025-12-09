# Tabla básica
resource "aws_dynamodb_table" "users" {
  name           = "users"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "user_id"
  range_key      = "email"
  
  attribute {
    name = "user_id"
    type = "S"  # String
  }
  
  attribute {
    name = "email"
    type = "S"
  }
  
  attribute {
    name = "created_at"
    type = "N"  # Number
  }
  
  # Índice secundario global
  global_secondary_index {
    name            = "EmailIndex"
    hash_key        = "email"
    projection_type = "ALL"
  }
  
  # Índice secundario local
  local_secondary_index {
    name            = "CreatedAtIndex"
    range_key       = "created_at"
    projection_type = "ALL"
  }
  
  tags = {
    Name        = "Users Table"
    Environment = "dev"
  }
}

# Tabla con más opciones
resource "aws_dynamodb_table" "products" {
  name           = "products"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "product_id"
  
  attribute {
    name = "product_id"
    type = "S"
  }
  
  # TTL (Time To Live)
  ttl {
    enabled        = true
    attribute_name = "expires_at"
  }
  
  # Stream para eventos
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  
  tags = {
    Name = "Products"
  }
}