variable "cidr_block" {
  type        = string
  default     = "172.16.0.0/21"
  description = "VPC CIDR block"
}

variable "environment_name" {
  type        = string
  description = "Environment name"

}

variable "region" {
  type        = string
  description = "AWS region"
}


variable "subnets" {
  type = map(object({
    az     = string
    cidr   = string,
    public = bool
  }))

  default = {
    private-az-a = {
      "az"     = "a"
      "cidr"   = "172.16.0.0/24",
      "public" = false
    },
    private-az-b = {
      "az"     = "b"
      "cidr"   = "172.16.1.0/24",
      "public" = false
    }
    public-az-a = {
      "az"     = "a"
      "cidr"   = "172.16.6.0/24",
      "public" = true
    },
    public-az-b = {
      "az"     = "b"
      "cidr"   = "172.16.7.0/24",
      "public" = true
  } }

  description = "Subnets to provision"
}