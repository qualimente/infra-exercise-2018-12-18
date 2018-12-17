provider "aws" {
  region = "us-east-1"

  //  region = "${var.region}"

  version = "1.52"
}

provider "template" {
  version = "1.0"
}
