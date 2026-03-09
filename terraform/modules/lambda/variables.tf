variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "nodejs20.x"
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "index.handler"
}

variable "timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Lambda function memory size in MB"
  type        = number
  default     = 256
}

variable "source_code_path" {
  description = "Path to the Lambda deployment package (zip file)"
  type        = string
}

variable "azure_tenant_id" {
  description = "Azure AD Tenant ID for Microsoft Graph API"
  type        = string
  sensitive   = true
}

variable "azure_client_id" {
  description = "Azure App Registration Client ID"
  type        = string
  sensitive   = true
}

variable "azure_client_secret" {
  description = "Azure App Registration Client Secret"
  type        = string
  sensitive   = true
}

variable "sender_email" {
  description = "Email address of the sender (SENDER_USER_ID)"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
