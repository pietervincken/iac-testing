variable "instance_id" {
    description = "The id of the instance to create alert rules for"
    type        = string
    validation {
        condition = can(regex("^i-[0-9a-fA-F]{8,}$", var.instance_id))
        error_message = "The instance_id must be a valid EC2 instance ID (e.g., i-xxxxxxxx or i-xxxxxxxxxxxxxxxxx)."
    }
}