provider "aws" {
  region = "us-east-1"

  //  region = "${var.region}"

  version = "1.52"
}

provider "template" {
  version = "1.0"
}


// Reconfigure backend to use remote state - START

terraform {
  backend "s3" {
    bucket     = "qm-training-cm-us-east-1"
    key        = "infra/terraform/qm-sandbox/us-east-1/cm/exercise-skuenzli.tfstate"
    region     = "us-east-1"
    encrypt    = true
    dynamodb_table = "TerraformStateLock"
  }
}

// Reconfigure backend to use remote state - END