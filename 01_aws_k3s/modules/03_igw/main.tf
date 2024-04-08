resource "aws_internet_gateway" "k3s_cluster_igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "k3s_cluster_igw"
  }
}
