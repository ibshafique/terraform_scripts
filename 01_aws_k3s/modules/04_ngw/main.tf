resource "aws_eip" "k3s_cluster_ngw_eip" {
  domain = "vpc"
  tags = {
    Name = "k3s_cluster_ngw_eip"
    Type = "IPV4"
  }
}

resource "aws_nat_gateway" "k3s_cluster_ngw" {
  allocation_id = aws_eip.k3s_cluster_ngw_eip.id
  subnet_id     = var.pub_sub_id
  tags = {
    Name = "k3s_cluster_ngw"
  }
}