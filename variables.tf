variable "aws_region" {
  description = "AWS hosting region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "Main VPC address range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "external_subnet_cidr" {
  description = "External subnet address range"
  type        = string
  default     = "10.0.1.0/24"
}

variable "internal_subnet_cidr" {
  description = "Internal subnet address range"
  type        = string
  default     = "10.0.2.0/24"
}

variable "admin_cidr" {
  description = "Your public IP address allowed to administer Linux servers"
  type        = string
}

variable "school_public_cidr" {
  description = "School public IP address for future IPsec VPN configuration"
  type        = string
  default     = null
  nullable    = true
}

variable "key_name" {
  description = "AWS EC2 key pair used for instance administration"
  type        = string
}