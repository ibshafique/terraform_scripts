resource "aws_eip" "k3s_cluster_bastion_eip" {
  domain = "vpc"
  tags = {
    Name = "k3s_cluster_bastion_eip"
    Type = "IPV4"
  }
}

resource "aws_instance" "bastion" {
  ami                         = "ami-080e1f13689e07408" #Ubuntu Server 22.04 LTS (HVM)
  instance_type               = "t2.medium"
  subnet_id                   = var.pub_sub_id
  key_name                    = var.k3s_cluster_keypair_id
  associate_public_ip_address = false
  private_ip                  = "10.242.100.5"
  availability_zone           = "us-east-1a"
  vpc_security_group_ids      = [var.bastion_sg_id]
  root_block_device {
    volume_size           = 10
    delete_on_termination = true
    encrypted             = false
    volume_type           = "gp3"
    iops                  = 5000
    tags = {
      Name = "k3s_cluster_bastion_root_blk_ebs"
    }
  }
  tags = {
    Name = "bastion",
    OS   = "Ubuntu"
  }
  user_data = <<-EOF
              #!/bin/bash
              exec > /root/cloud-init.out 2>&1
              set -x
              hostnamectl set-hostname bastion
              sudo apt update
              sudo apt upgrade -y
              echo "10.242.110.5      controlplane" >> /etc/hosts
              echo "10.242.120.5      workernode1" >> /etc/hosts
              echo "10.242.130.5      workernode2" >> /etc/hosts
              echo '${base64encode(file("./ssh/k3s_cluster_key"))}' | base64 --decode > /home/ubuntu/.ssh/id_rsa
              chmod 600 /home/ubuntu/.ssh/id_rsa
              chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
              EOF
  lifecycle {
    #prevent_destroy = true
    ignore_changes = [associate_public_ip_address] #the eip added to the instance is conflictng with the eip association prevention tag
  }
}

resource "aws_eip_association" "k3s_cluster_bastion_eip_association" {
  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.k3s_cluster_bastion_eip.id
}