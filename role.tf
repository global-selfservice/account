module "ADFS" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles-with-saml"
  version = "~> 3.8.0"

  create_admin_role = false
  admin_role_name   = "ADFS-FullAccess"

  create_readonly_role = true
  readonly_role_name   = "ADFS-CloudRO"

  provider_id = "arn:aws:iam::${local.account_id}:saml-provider/TIG_ADFS"
}
