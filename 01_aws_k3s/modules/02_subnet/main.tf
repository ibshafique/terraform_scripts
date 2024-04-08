resource "aws_subnet" "pub_sub" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.242.100.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub_sub",
    type = "public"
  }
}

locals {
  pvt_subs_cidrs      = ["10.242.110.0/24", "10.242.120.0/24", "10.242.130.0/24"]
  pvt_subs_names      = ["pvt_sub1", "pvt_sub2", "pvt_sub3"]
  private_subnet_type = ["private", "private", "private"]
}

resource "aws_subnet" "pvt_subs" {
  vpc_id            = var.vpc_id
  count             = length(local.pvt_subs_cidrs)
  cidr_block        = local.pvt_subs_cidrs[count.index]
  availability_zone = "us-east-1a"
  tags = {
    Name = local.pvt_subs_names[count.index]
    Type = local.private_subnet_type[count.index]
  }
}