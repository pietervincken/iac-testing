output "instance_id" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.this.id
}

output "name" {
  description = "Name of the EC2"
  value = aws_instance.this.tags_all["Name"]
}