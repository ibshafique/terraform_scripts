resource "aws_vpc" "k3s_cluster_vpc" {
  cidr_block           = "10.242.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "k3s_cluster_vpc"
  }
}