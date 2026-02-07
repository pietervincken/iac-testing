variable "env" {
    description = "The environment (e.g., tst, dev, acc, prd)"
    type        = string
    validation {
        condition     = contains(["tst", "dev", "acc", "prd"], var.env)
        error_message = "The env variable must be one of: tst, dev, acc, prd."
    }
}

variable "name" {
    description = "The name postfix to be used for created resources"
    type        = string
}

variable "subnet_id" {
    description = "The ID of the subnet to launch the EC2 instance in"
    type        = string
}