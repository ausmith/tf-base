variable "azs" {
  # If going to another region, make this more configurable
  default = [
    "us-east-1a",
    "us-east-1b",
  ]
}

resource "aws_subnet" "public" {
  count  = 2
  vpc_id = "${aws_vpc.primary.id}"

  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = "${element(var.azs, count.index)}"

  tags {
    Name = "${var.env_name} public subnet ${element(var.azs, count.index)}"
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}
