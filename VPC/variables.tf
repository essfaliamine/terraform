variable "region" {
  type    = string
  default = "eu-west-3"
}



variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.150.1.0/24", "10.150.2.0/24", "10.150.3.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.150.4.0/24", "10.150.5.0/24", "10.150.6.0/24"]
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
}
