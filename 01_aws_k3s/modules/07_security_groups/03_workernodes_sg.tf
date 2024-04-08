resource "aws_security_group" "workernode_sg" {
  name        = "workernode_sg"
  description = "Security group for workernodes"

  vpc_id = var.vpc_id

  # Inbound rule for SSH access from the jump host
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}