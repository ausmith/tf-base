resource "aws_s3_bucket" "s3_logging_bucket" {
  bucket = "ausmith-${var.env_name}-bucket-logging-us-east-1"
  acl    = "log-delivery-write"

  lifecycle_rule {
    id      = "log"
    prefix  = ""
    enabled = true

    transition {
      days          = 120
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}

resource "aws_s3_bucket" "site_logs" {
  bucket = "ausmith-${var.env_name}-site-logs-us-east-1"
  acl    = "private"

  lifecycle_rule {
    id      = "log"
    prefix  = ""
    enabled = true

    transition {
      days          = 120
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }

  logging {
    target_bucket = "${aws_s3_bucket.s3_logging_bucket.id}"
    target_prefix = "ausmith-site-logs-us-east-1/"
  }
}
