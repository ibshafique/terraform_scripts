resource "aws_key_pair" "k3s_cluster_keypair" {
  key_name   = "k3s_cluster_key"
  public_key = file("./ssh/k3s_cluster_key.pub")
  #depends_on = [null_resource.generate_ssh_keys]
}