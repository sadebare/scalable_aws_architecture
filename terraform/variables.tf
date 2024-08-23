variable "aws_region" {
  description = "AWS region where resources will be created"
  type = string
  default = "us-east-1"
}

variable "cidr_block" {
  description = "AWS cidr range where resources will be created"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for public subnet 1."
  type        = string
  default     = "10.0.1.0/24" # Change to your desired CIDR block for public subnet 1
}

variable "public_subnet_cidr_block_2" {
  description = "CIDR block for public subnet 2."
  type        = string
  default     = "10.0.2.0/24" # Change to your desired CIDR block for public subnet 2
}

variable "private_subnet_cidr_block_1" {
  description = "CIDR block for private subnet 1."
  type        = string
  default     = "10.0.3.0/24" # Change to your desired CIDR block for private subnet 1
}

variable "private_subnet_cidr_block_2" {
  description = "CIDR block for private subnet 2."
  type        = string
  default     = "10.0.4.0/24" # Change to your desired CIDR block for private subnet 2
}

variable "availability_zone1" {
  description = "Availability Zone for subnet 1."
  type        = string
  default     = "us-east-1a" # Change to your desired Availability Zone for subnet 1
}

variable "availability_zone2" {
  description = "Availability Zone for subnet 2."
  type        = string
  default     = "us-east-1b" # Change to your desired Availability Zone for subnet 2
}

variable "image_id" {
  description = "Image id of os"
  type        = string
  default     = "ami-0e86e20dae9224db8" 
}

variable "instance_type" {
  description = "Image id of os"
  type        = string
  default     = "t2.micro" 
}

variable "rds_username" {
  description = "username for rds"
  type        = string
}

variable "rds_password" {
  description = "password for rds"
  type        = string
}