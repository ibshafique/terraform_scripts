resource "aws_route_table_association" "pub_sub_association" {
  subnet_id      = var.pub_sub_id
  route_table_id = var.pub_rt_id
}

resource "aws_route_table_association" "pvt_sub1_association" {
  subnet_id      = var.pvt_sub1_id
  route_table_id = var.pvt_rt_id
}

resource "aws_route_table_association" "pvt_sub2_association" {
  subnet_id      = var.pvt_sub2_id
  route_table_id = var.pvt_rt_id
}

resource "aws_route_table_association" "pvt_sub3_association" {
  subnet_id      = var.pvt_sub3_id
  route_table_id = var.pvt_rt_id
}