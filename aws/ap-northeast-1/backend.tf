terraform {
  backend "remote" {
    organization = "hayata-yamamoto"
    workspaces {
      name = "sequential-aws-batch-job"
    }
  }
}
