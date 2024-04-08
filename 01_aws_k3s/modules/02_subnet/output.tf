output "pub_sub_id" {
  value = aws_subnet.pub_sub.id
}

output "pvt_sub1_id" {
  value = aws_subnet.pvt_subs[0].id
}

output "pvt_sub2_id" {
  value = aws_subnet.pvt_subs[1].id
}

output "pvt_sub3_id" {
  value = aws_subnet.pvt_subs[2].id
}