# Self Service Account
In this repository we would maintain the resources specific to the AWS account. In case self service we have the below 2 AWS account

1. globalselfservicedev (435559816706)
2. globalselfservicelive (191125840152)

The aws resources like, IAM roles, Route53 Hosted zone, SAML integration etc which are specific to AWS account as a whole rather than for every individual environment is maintained in this repository.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| delegation | External delegation | map(list(string)) | `{}` | no |
| dev\_worker | List of developers roles | list(string) | `[]` | no |
| devops\_management | List of DevOpsManagement users | list(string) | `[]` | no |
| external\_zone | External zone | string | `""` | no |
| production\_account | Production account | bool | `"false"` | no |

## Outputs

| Name | Description |
|------|-------------|
| external\_domain\_name | External DNS domain name |
| external\_zone\_id | External DNS zone ID |
