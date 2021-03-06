resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.primary.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "${var.env_name} public route table"
  }
}
