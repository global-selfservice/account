module "ADFS" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles-with-saml"
  version = "~> 2.0"

  create_admin_role = false
  admin_role_name   = "ADFS-FullAccess"

  create_readonly_role = true
  readonly_role_name   = "ADFS-CloudRO"

  provider_name = "TIG_ADFS"
  provider_id   = "arn:aws:iam::${local.account_id}:saml-provider/TIG_ADFS"
}

module "cost" {
  source = "github.com/global-devops-terraform/cost-role?ref=v1.0.2"

  cost_role = module.common.cost_lambda_role
}
