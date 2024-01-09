resource "mongodbatlas_cloud_provider_access_setup" "setup_only" {
  project_id    = var.project_id
  provider_name = "AWS"
}

resource "aws_iam_role" "kms_role" {
  name = "kms_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "${mongodbatlas_cloud_provider_access_setup.setup_only.aws_config[0].atlas_aws_account_arn}"
        },
        Action = "sts:AssumeRole",
        Condition = {
          StringEquals = {
            "sts:ExternalId" = "${mongodbatlas_cloud_provider_access_setup.setup_only.aws_config[0].atlas_assumed_role_external_id}"
          }
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "kms_policy" {
  name = "kms_policy"
  role = aws_iam_role.kms_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:DescribeKey",
          "kms:EnableKey"
        ],
        Resource = "<CMK_ARN>"
      },
    ]
  })
}

output "setup_only" {
    value = "${mongodbatlas_cloud_provider_access_setup.setup_only.role_id}"
}

resource "mongodbatlas_cloud_provider_access_authorization" "auth_role" {
   project_id =  var.project_id
   role_id    =  "${mongodbatlas_cloud_provider_access_setup.setup_only.role_id}"
   aws {
      iam_assumed_role_arn = "${aws_iam_role.kms_role.arn}"
   }
}
