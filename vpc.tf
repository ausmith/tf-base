resource "aws_vpc" "primary" {
  cidr_block           = "10.0.0.0/23"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "tf_${var.env_name}_primary_vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.primary.id}"
}
