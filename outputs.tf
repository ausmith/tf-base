output "s3_logging_bucket" {
  value = "${aws_s3_bucket.s3_logging_bucket.bucket}"
}

output "s3_logging_bucket_arn" {
  value = "${aws_s3_bucket.s3_logging_bucket.arn}"
}

output "s3_site_logs_bucket" {
  value = "${aws_s3_bucket.site_logs.bucket}"
}

output "s3_site_logs_arn" {
  value = "${aws_s3_bucket.site_logs.arn}"
}

output "vpc_id" {
  value = "${aws_vpc.primary.id}"
}

output "sg_basic_server_needs" {
  value = "${aws_security_group.basic_server_needs.id}"
}

output "sg_simple_web_server" {
  value = "${aws_security_group.simple_web_server.id}"
}

output "sg_emergency_ssh_access" {
  value = "${aws_security_group.emergency_ssh_access.id}"
}

output "subnet_public_list" {
  value = [
    "${aws_subnet.public.*.id}",
  ]
}
