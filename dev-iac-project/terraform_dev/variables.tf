variable "ami" {}
variable "key_name" {}
variable "instance_type" {
  default = "t3.medium"
}
variable "vpc_cidr" {
  default = ""
}


variable "key_name" {
  default = ""
}
variable "region" {
  default = "us-west-2"
}