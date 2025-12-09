output "config_path" {
  value = local_file.config.filename
}

output "instance_name" {
  value = random_pet.instance.id
}