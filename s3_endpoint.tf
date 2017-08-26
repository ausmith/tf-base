resource "aws_vpc_endpoint" "s3" {
  vpc_id = "${aws_vpc.primary.id}"

  # If going to another region, also need to parameterize this
  service_name = "com.amazonaws.us-east-1.s3"
}

resource "aws_vpc_endpoint_route_table_association" "public_s3_association" {
  # There is basically no reason NOT to have an S3 endpoint as they
  # do not cost anything extra (money savings) and move traffic off
  # NAT Gateways in private subnets.
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"

  route_table_id = "${aws_route_table.public_route_table.id}"
}
