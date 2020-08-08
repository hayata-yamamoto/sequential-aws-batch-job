## Requirements

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_zone | n/a | `string` | `"ap-northeast-1a"` | no |
| cidr\_blocks | n/a | `map(string)` | <pre>{<br>  "global": "0.0.0.0/0",<br>  "subnet": "10.2.0.0/24",<br>  "vpc": "10.2.0.0/16"<br>}</pre> | no |
| region | aws region | `string` | `"ap-northeast-1"` | no |

## Outputs

No output.

