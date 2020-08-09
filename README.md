# Sequential AWS Batch Job

![Python Code Assessment](https://github.com/hayata-yamamoto/sequential-aws-batch-job/workflows/Python%20Code%20Assessment/badge.svg?branch=master&event=push)

## What's this

This repository shows **how to write sequential AWS Batch Job in Terraform**.

## Contains and Not-Contains

**Contains**

- AWS Batch creation in Terraform
- Lambda-based batch job control
- Terraform Cloud CI/CD
  - This repository isn't assumed to be executed on local
- Lambda code check by GitHub Actions

**Not-Contains**

- Custom image execution
  - Just adding ECR resources and rewrite job definition
- StepFunction implementation
- Sequential and parallel batch job workflow

## Hello World

This repository demands IAM user secrets to communicate with AWS. This user must be able to handle AWS resources. It may be appropriate to assign PowerUserAccess + IAMFullAccess or AdministratorAccess.

```bash
$ git clone https://github.com/hayata-yamamoto/sequential-aws-batch-job.git

# tfenv if multiple terraform versions used
# https://github.com/tfutils/tfenv
$ brew install tfenv
$ tfenv install 0.12.29
$ tfenv use 0.12.29

# direnv if needed
# https://github.com/direnv/direnv

$ brew install direnv
$ eval "$(direnv hook zsh)" # for zsh
$ touch .envrc
$ echo "export AWS_ACCESS_KEY_ID=hoge" >> .envrc
$ echo "export AWS_SECRET_ACCESS_KEY=hoge" >> .envrc
$ echo "export AWS_REGION=ap-northeast-1" >> .envrc
$ echo "export AWS_DEFAUTL_REGION=ap-northeast-1" >> .envrc
$ direnv allow .

$ cd aws/ap-northeast-1
$ terraform init
$ terraform plan
```

## Stacks

**Python**

> Available: ^3.6

**Terraform**

```bash
❯❯❯ terraform version
Terraform v0.12.29
+ provider.aws v3.1.0
```

**AWS**

- AWS Batch
- CloudWatch Event
- Lambda
- VPC

**CI/CD**

GitHub Actions

- To check Python codes

Terraform Cloud

- To plan and apply terraform
- Slack notification
- State management
