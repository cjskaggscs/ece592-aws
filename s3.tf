# Create S3 bucket
resource "aws_s3_bucket" "week6-s3bucket" {
    bucket = "ece592-week6-skaggsc"
    acl = "private"

    versioning {
        enabled = true
    }

    lifecycle_rule {
        enabled = true
        id = "DeleteAfter30Days"
        expiration {
            days = 30
        }
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                kms_master_key_id = aws_kms_key.week6-kmsKey.arn
                sse_algorithm = "aws:kms"
            }
        }
    }
}
