# modules/simple-config/outputs.tf
output "config_path" {
  value = local_file.config.filename
}

output "instance_name" {
  value = random_pet.name.id
}