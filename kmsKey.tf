# Create KMS key
resource "aws_kms_key" "week6-kmsKey" {
    description = "Week 6 KMS key"
    key_usage = "ENCRYPT_DECRYPT"
    customer_master_key_spec = "SYMMETRIC_DEFAULT"
    }

# Alias the KMS key
resource "aws_kms_alias" "week6-kmsKeyAlias" {
    name = "alias/week6-kmsKey"
    target_key_id = aws_kms_key.week6-kmsKey.key_id
    }

