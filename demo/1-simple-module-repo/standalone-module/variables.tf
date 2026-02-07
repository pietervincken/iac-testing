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
    validation {
        condition = (
            length(var.name) >= 3 &&
            length(var.name) <= 63 &&
            can(regex("^[a-z0-9.-]+$", var.name)) &&
            !startswith(var.name, "-") &&
            !endswith(var.name, "-") &&
            !strcontains(var.name, "..") &&
            !strcontains(var.name, ".-") &&
            !strcontains(var.name, "-.")
        )
        error_message = "The name must be S3 compliant: 3-63 characters, lowercase letters, numbers, dots, hyphens, no consecutive periods, cannot start or end with a hyphen, and only allowed characters."
    }
}