# Create S3 bucket
resource "aws_s3_bucket" "week6-s3bucket" {
  bucket = "ece592-week6-skaggsc"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    id      = "DeleteAfter30Days"
    expiration {
      days = 30
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.week6-kmsKey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# Create lambda function permission
resource "aws_lambda_permission" "week6-bucket-lambda" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "arn:aws:lambda:us-east-1:678668937682:function:week6-lambda"
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.week6-s3bucket.arn
}

# Create the bucket event
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.week6-s3bucket.id

  lambda_function {
    lambda_function_arn = "arn:aws:lambda:us-east-1:678668937682:function:week6-lambda"
    events              = ["s3:ObjectCreated:*"]
  }
}
