provider "aws" {
  region = "us-west-2"
}

// Terraform state managed remotely.
terraform {
  backend "s3" {
    bucket         = "jscom-tf-backend"
    key            = "project/jscom-blog/state/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-state"
  }
}

data "terraform_remote_state" "jscom_common_data" {
  backend = "s3"
  config = {
    bucket = "jscom-tf-backend"
    key = "project/jscom-core-infra/state/terraform.tfstate"
    region = "us-west-2"
  }
}
