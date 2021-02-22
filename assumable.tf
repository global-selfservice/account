module "DevopsManagement" {
  source = "github.com/global-devops-terraform/iam-assumable-role?ref=v0.18.0"

  name = "DevopsManagement"

  trusted_role_arns = [for s in var.devops_management :
    "arn:aws:sts::${local.account_id}:assumed-role/${s}"
  ]

  policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]

  create          = length(var.devops_management) > 0
  create_can_role = true
}

module "DevAccess" {
  source = "github.com/global-devops-terraform/iam-assumable-role?ref=v0.18.0"

  name = "DevAccess"

  trusted_role_arns = [for s in var.developers :
    "arn:aws:sts::${local.account_id}:assumed-role/${s}"
  ]

  policy_arns = [aws_iam_policy.dev_iam_policy.arn]

  create          = length(var.developers) > 0
  create_can_role = true
}
