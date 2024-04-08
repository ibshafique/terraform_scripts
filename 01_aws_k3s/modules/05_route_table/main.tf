resource "aws_route_table" "pub_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "pub_rt"
  }
}

resource "aws_route_table" "pvt_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.ngw_id
  }
  tags = {
    Name = "pvt_rt"
  }
}