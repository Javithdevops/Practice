variable "sg_name" {
  default = "devsg"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "servertag" {
  default = "devserver"
}

variable "az" {
  default = ["us-east-1a","us-east-1b"]
}