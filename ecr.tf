locals {
  prod_workers = toset([
    module.common.cluster_worker_roles["selfservice-preprod"],
    module.common.cluster_worker_roles["selfservice-prod"]
  ])

  repos = toset([
    "selfservice-products-api",
    "selfservice-ui",
    "selfservice-ui-e2e-tests",
    "selfservice-products-data-import-job"
  ])

  ecr_repos = var.production_account ? toset([]) : local.repos

  policy_string = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 10 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_repository" "repo" {
  for_each = local.ecr_repos

  name = each.key

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "policy" {
  for_each = local.ecr_repos

  repository = aws_ecr_repository.repo[each.key].name

  policy = local.policy_string
}

resource "aws_ecr_repository_policy" "policy" {
  for_each = local.ecr_repos

  repository = aws_ecr_repository.repo[each.key].name
  policy     = data.aws_iam_policy_document.ecr[each.key].json
}

data "aws_iam_policy_document" "ecr" {
  for_each = local.ecr_repos

  statement {
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = local.prod_workers
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]
  }
}
