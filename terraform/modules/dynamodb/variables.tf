variable "tables" {
  description = "List of DynamoDB tables to create"
  type = list(object({
    name           = string
    hash_key       = string
    range_key      = string
    billing_mode   = string
    read_capacity  = number
    write_capacity = number
    attributes = list(object({
      name = string
      type = string
    }))
    global_secondary_indexes = list(object({
      name               = string
      hash_key           = string
      range_key          = string
      projection_type    = string
      non_key_attributes = list(string)
      read_capacity      = number
      write_capacity     = number
    }))
  }))
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}
