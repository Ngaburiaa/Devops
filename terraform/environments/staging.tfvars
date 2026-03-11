# Common Variables (Non-Sensitive)
# Environment: Staging

# AWS Configuration
aws_region        = "us-east-1"
aws_account_id    = "875486186130"
environment       = "staging"
project_name      = "DevopsApp"
frontend_prod_url = "https://DevopsApp-frontend-staging.DevopsDemo.com"
api_base_url_prod = "https://DevopsApp-api-staging.DevopsDemo.com"
frontend_url      = "https://DevopsApp-frontend-staging.DevopsDemo.com"
api_base_url      = "https://DevopsApp-api-staging.DevopsDemo.com"
# VPC Configuration
vpc_cidr        = "10.1.0.0/16" # Different CIDR for staging
az_count        = 2
public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnets = ["10.1.10.0/24", "10.1.11.0/24"]

# Application Configuration
app_port          = 9000
health_check_path = "/health"

# Security Configuration (Restricted for staging)
allowed_ips     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"] # Private networks only
allowed_domains = ["staging.DevopsApp.com"]

# Database Configuration (Non-Sensitive)
db_subnet_group_name = "DevopsApp-vpc-db-subnet-group-v2"
db_instance_class = "db.t3.micro" # Smaller instance for staging
# Note: db_password should be set via environment variable or AWS Secrets Manager
# Export TF_VAR_db_password="your_password_here" or use AWS Secrets Manager

# ECS Configuration (Smaller for staging)
ecs_desired_count = 1
ecs_cpu           = 256
ecs_memory        = 512

# Notification
notification_emails = ["dev-alerts@DevopsApp.com"]

# DNS Configuration
domain_names = ["DevopsDemo.com", "DevopsApp-frontend-staging.DevopsDemo.com"]

# CloudFront Cache Settings
cloudfront_cache_settings = {
  static = {
    min_ttl     = 60   # Shorter cache for staging
    default_ttl = 300  # 5 minutes
    max_ttl     = 3600 # 1 hour
  }
  dynamic = {
    min_ttl     = 0
    default_ttl = 0
    max_ttl     = 300 # 5 minutes
  }
}


# Lambda Functions Configuration - DISABLED (using ECS backend instead)
# lambda_functions = [
#   {
#     name        = "DevopsApp-api-handler"
#     runtime     = "nodejs16.x"
#     handler     = "index.handler"
#     timeout     = 30
#     memory_size = 128
#     zip_file    = "./lambda/DevopsApp-api-handler.zip"
#     environment_variables = {
#       DYNAMODB_TABLE = "DevopsApp-items"
#     }
#   }
# ]
lambda_functions = []

# DynamoDB Tables Configuration
dynamodb_tables = [
  {
    name           = "DevopsApp-items"
    hash_key       = "id"
    range_key      = ""
    billing_mode   = "PAY_PER_REQUEST"
    read_capacity  = 0
    write_capacity = 0
    attributes = [
      {
        name = "id"
        type = "S"
      }
    ]
    global_secondary_indexes = []
  }
]

# Backup Configuration
backup_retention_days      = 7
enable_cross_region_backup = false
cross_region_backup_region = "us-west-2"

# WAF Configuration
waf_rate_limit        = 10000
waf_allowed_countries = ["US", "CA", "GB", "AU"]

# ACM Certificate for HTTPS
acm_certificate_arn = "arn:aws:acm:us-east-1:471744311346:certificate/0db2d0be-ebe8-454e-81eb-548568726703"

