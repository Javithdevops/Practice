variable "sg_name" {
  default = "devsg"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "servertag" {
  default = "devserver"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpctag" {
  default = "Mainvpc"
}

variable "pubnet1" {
  default = "10.0.1.0/24"
}

variable "pubnet2" {
  default = "10.0.2.0/24"
}

variable "prinet1" {
  default = "10.0.3.0/24"
}

variable "prinet2" {
  default = "10.0.4.0/24"
}

variable "pubsubnettag" {
  default = ["pubsub1","pubsub2"]
}

variable "prisubnettag" {
  default = ["prisub1","prisub2"]
}

variable "az" {
  default = ["us-east-1a","us-east-1b"]
}