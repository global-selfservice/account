data "aws_iam_policy_document" "dev_policy_document" {

  statement {
    actions = [
      "acm:*",
      "ec2:Start*",
      "ec2:Stop*",
      "ec2:Describe*"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "eks:DescribeCluster",
      "eks:ListClusters"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "iam:GetRole",
      "iam:GetUser",
      "iam:GetUserPolicy",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListAttachedRolePolicies",
      "iam:ListServerCertificates"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "support:*",
      "aws-portal:ViewBilling"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "s3:*"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "sqs:*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "dev_iam_policy" {
  name   = "dev-iam-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.dev_policy_document.json
}
