variable "sg_name" {}

variable "instance_type" {}

variable "servertag" {}

variable "netcidr" {}

variable "tag" {}

variable "pubsubnet1_cidr" {}

variable "pubsubnet2_cidr" {}

variable "prisubnet1_cidr" {}

variable "prisubnet2_cidr" {}

variable "subnettag_pub" {}

variable "subnettag_pri" {}

variable "az" {
  type = list(string)
}