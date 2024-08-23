resource "aws_iam_role" "ec2_rds_access" {
  name = "ec2-rds-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_policy" "rds_access_policy" {
  name        = "RDSAccessPolicy"
  description = "Policy to allow EC2 instances to access RDS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "rds:DescribeDBInstances",
          "rds:Connect",
          "rds:DescribeDBLogFiles",
          "rds:DownloadDBLogFilePortion",
          "rds:DescribeDBParameters",
          "rds:DescribeDBSecurityGroups",
          "rds:DescribeDBSnapshots",
          "rds:DescribeDBSubnetGroups",
          "rds:DescribeEventSubscriptions",
          "rds:DescribeEvents",
          "rds:DescribeOptionGroups",
          "rds:DescribeOrderableDBInstanceOptions",
          "rds:DescribePendingMaintenanceActions"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_rds_policy" {
  role       = aws_iam_role.ec2_rds_access.name
  policy_arn = aws_iam_policy.rds_access_policy.arn
}

resource "aws_iam_instance_profile" "ec2_rds_access_profile" {
  name = "ec2-rds-access-profile"
  role = aws_iam_role.ec2_rds_access.name
}



# IAM Policy for S3 Bucket Access
resource "aws_iam_policy" "s3_access_policy" {
  name        = "S3AccessPolicy"
  description = "Policy to allow EC2 instances to access a specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"],
        Effect   = "Allow",
        Resource = [
          aws_s3_bucket.my_secure_bucket.arn,
          "${aws_s3_bucket.my_secure_bucket.arn}/*"
        ]
      }
    ]
  })
}

# Attach S3 Access Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.ec2_rds_access.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}


resource "aws_s3_bucket_policy" "my_secure_bucket_policy" {
  bucket = aws_s3_bucket.my_secure_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::172316546414:role/${aws_iam_role.ec2_rds_access.name}"
        },
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "${aws_s3_bucket.my_secure_bucket.arn}",
          "${aws_s3_bucket.my_secure_bucket.arn}/*"
        ]
      }
    ]
  })
}
