output "vm_instance_id" {
  value       = module.vm.instance_id
  description = "The ID of the EC2 instance"
}

output "vm_instance_name" {
  value       = module.vm.name
  description = "The name of the EC2 instance"
}

output "bucket" {
  value       = module.bucket.name
  description = "The name of the S3 bucket created"
}