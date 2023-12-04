variable "region" {
  default = "us-west-2"
}

variable "eks_cluster_name" {
  default = "weiss-eks-cluster"
}

variable "key_name" {
  default = "terraform-key-name"
}

variable "vpc_id" {
  default = "vpc-0548a5c21133fcf97"
}

variable "subnet_ids" {
  default = [
    "subnet-0deb3806fce4d36bd",
    "subnet-02045120d377f86f6",
    "subnet-0b1608abae2e46b80",
  ]
}

variable "desired_capacity" {
  default = 2
}

variable "max_capacity" {
  default = 3
}

variable "min_capacity" {
  default = 1
}

variable "cluster_version" {
  default = "1.21"
}
