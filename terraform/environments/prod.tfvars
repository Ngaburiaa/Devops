# AWS Configuration
aws_region        = "us-east-1"
aws_account_id    = "471744311346"
environment       = "production"
project_name      = "DevopsApp"
frontend_url      = "https://DevopsApp-frontend.thejitutech.com"
frontend_prod_url = "https://DevopsApp-frontend.thejitutech.com"
api_base_url_prod = "https://DevopsApp-api.thejitutech.com"
api_base_url      = "https://DevopsApp-api.thejitutech.com"

# VPC Configuration
vpc_cidr        = "10.2.0.0/16"
az_count        = 2
public_subnets  = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnets = ["10.2.10.0/24", "10.2.11.0/24"]

# Application Configuration
app_port          = 9000
health_check_path = "/health"

# Security Configuration (Restricted for production)
allowed_ips     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"] # Private networks only
allowed_domains = ["thejitutech.com"]

# Database Configuration (Non-Sensitive)
db_instance_class = "db.t3.medium"


# ECS Configuration 
ecs_desired_count = 1
ecs_cpu           = 512
ecs_memory        = 1024

# Notification
notification_emails = ["DevopsApp@griffinglobaltech.com"]

# DNS Configuration
# NOTE: thejitutech.com is currently used by staging CloudFront
# Set to empty for now - production will use CloudFront default URL (*.cloudfront.net)
# To use custom domain later: remove from staging, add SSL cert, then set here
domain_names = ["DevopsApp-frontend.thejitutech.com"]


# CloudFront Cache Settings
cloudfront_cache_settings = {
  static = {
    min_ttl     = 60   # Shorter cache for production
    default_ttl = 300  # 5 minutes
    max_ttl     = 3600 # 1 hour
  }
  dynamic = {
    min_ttl     = 0
    default_ttl = 0
    max_ttl     = 300 # 5 minutes
  }
}

# Database User Configuration (Sensitive data via environment variables)



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
