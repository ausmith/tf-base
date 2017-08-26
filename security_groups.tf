resource "aws_security_group" "simple_web_server" {
  name        = "${var.env_name}_simple_web_server"
  description = "Allow access to 80 and 443"
  vpc_id      = "${aws_vpc.primary.id}"

  tags {
    Name = "${var.env_name}_simple_web_server"
  }
}

resource "aws_security_group_rule" "simple_web_server_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.simple_web_server.id}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "simple_web_server_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.simple_web_server.id}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group" "basic_server_needs" {
  name        = "${var.env_name}_basic_needs"
  description = "Allow basic in/out needs to EC2"
  vpc_id      = "${aws_vpc.primary.id}"

  tags {
    Name = "${var.env_name}_basic_needs"
  }
}

resource "aws_security_group_rule" "s3_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.basic_server_needs.id}"

  prefix_list_ids = [
    "${aws_vpc_endpoint.s3.prefix_list_id}",
  ]
}

resource "aws_security_group_rule" "ntp" {
  type              = "egress"
  from_port         = 123
  to_port           = 123
  protocol          = "udp"
  security_group_id = "${aws_security_group.basic_server_needs.id}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group" "emergency_ssh_access" {
  name = "${var.env_name}_emergency_ssh"
  description = "Allow ssh, intended for emergencies and should be unused normally"
  vpc_id = "${aws_vpc.primary.id}"

  tags {
    Name = "${var.env_name}_emergency_ssh"
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.emergency_ssh_access.id}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}
