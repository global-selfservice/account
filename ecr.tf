locals {

  repos = toset([
    "selfservice-products-api",
    "selfservice-ui"
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
