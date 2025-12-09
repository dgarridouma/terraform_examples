# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  
  endpoints {
    ec2 = "http://localhost:4566"
  }
  
  access_key = "test"
  secret_key = "test"
  
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

# Crear instancias EC2
resource "aws_instance" "web" {
  count = 3
  
  ami           = "ami-12345678"
  instance_type = "m1.small"
  
  tags = {
    Name        = "web-server-${count.index}"
    Environment = "dev"
    Role        = "webserver"
  }
}


# Crear una IP elástica por instancia
resource "aws_eip" "web_ip" {
  count = length(aws_instance.web)

  instance = aws_instance.web[count.index].id

  tags = {
    Name = "web-server-${count.index}-eip"
  }
}


# Outputs
output "instance_ids" {
  description = "IDs de las instancias"
  value       = aws_instance.web[*].id
}

output "instance_info" {
  description = "Información de instancias"
  value = {
    for idx, instance in aws_instance.web :
    "server-${idx}" => {
      id   = instance.id
      type = instance.instance_type
      name = instance.tags.Name
    }
  }
}


output "elastic_ips" {
  description = "IPs elásticas asignadas"
  value       = aws_eip.web_ip[*].public_ip
}
