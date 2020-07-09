variable "name" {
  description = "VPC Name"
  default = "mytestvpc"
}

variable "auto_create_subnetworks" {
  default     = "true"
  description = "false = creates custom VPC, true = automatically creates subnets in each region"
}

variable "region" {
  default="us-west1"
}

variable "project" {
  default = "gleaming-design-282503"
}
