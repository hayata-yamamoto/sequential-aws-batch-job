## Requirements

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_key | n/a | `any` | n/a | yes |
| cidr\_blocks | n/a | `map(string)` | <pre>{<br>  "global": "0.0.0.0/0",<br>  "subnet": "10.1.0.0/24",<br>  "vpc": "10.1.0.0/16"<br>}</pre> | no |
| region | aws region | `string` | `"ap-northeast-1"` | no |
| secret\_key | n/a | `any` | n/a | yes |

## Outputs

No output.

