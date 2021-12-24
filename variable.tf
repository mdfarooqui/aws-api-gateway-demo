variable "region" {  
    default = "us-east-1" 
}

provider "aws" {
  region = "${var.region}"
}

variable "aws_tenant" { 
    default = "HEREYOURIDTENAT"
}

variable "apigateway_version"   { 
    default = "1.1.0"
}

variable "apigateway_name" { 
    default = "coustomer-profile-service"
}

variable "apigateway_environment" { 
    default = "dev"
}

variable "app_company"  {
    default = "company"
}