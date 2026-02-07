variable "instance_id" {
    description = "The ID of the EC2 instance to validate"
    type        = string
}

data "aws_instance" "this" {
    instance_id = var.instance_id
}