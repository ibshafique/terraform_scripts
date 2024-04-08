output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "controlplane_sg_id" {
  value = aws_security_group.controlplane_sg.id
}