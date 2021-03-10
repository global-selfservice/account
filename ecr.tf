locals {
  prod_workers = [
    module.common.cluster_worker_roles["selfservice-preprod"],
    module.common.cluster_worker_roles["selfservice-prod"]
  ]

  repos = [
    "selfservice-api-gateway",
    "selfservice-api-tests",
    "selfservice-assets-admin-api",
    "selfservice-assets-api",
    "selfservice-businesses-api",
    "selfservice-campaigns-admin-api",
    "selfservice-campaigns-api",
    "selfservice-payments-gateway",
    "selfservice-products-api",
    "selfservice-products-data-import-job",
    "selfservice-ui",
    "selfservice-ui-e2e-tests"
  ]

  policy_string = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 10 images"
      action       = { type = "expire" }

      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
    }]
  })

  ecr_repos = toset(var.production_account ? [] : local.repos)
}

resource "aws_ecr_repository" "repo" {
  for_each = local.ecr_repos

  name                 = each.key
  image_tag_mutability = "IMMUTABLE"

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

data "aws_caller_identity" "current" {}

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
