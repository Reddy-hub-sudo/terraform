variable "subnet_cidr" {
    type = list(string)
    default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24"]
    description = "enter the cidr_block range"
}
variable "vpc_cidr" {
    type = string
    default = "192.168.0.0/16"
    description = "enter the vpc_cidr range"
}
variable  "region" {
    type = string
    default = "us-east-2"
    description = "select the region"
}
variable  "subnets_names" {
    type = list(string)
    default = ["web1", "web2", "app1", "app2"]
    description = "subnet names"
}
variable "subnetazs" {
    type = list(string)
    default = ["us-east-2a", "us-east-2b", "us-east-2a", "us-east-2b"]
    description = "select the  subnets"
}