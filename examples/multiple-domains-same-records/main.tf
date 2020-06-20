# ---------------------------------------------------------------------------------------------------------------------
# CREATE TWO ZONES WITH SAME RECORDS
#
# We create two zones and attach the same set of records to both. The zones will share the same delegation set.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# Set Terraform and Provider Requirements for running this example
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12.20"

  required_providers {
    aws = ">= 2.45"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region = "us-east-1"
}

module "zones" {
  source  = "mineiros-io/route53/aws"
  version = "0.2.2"

  # Create two zones
  name = [
    "mineiros.io",
    "mineiros.com"
  ]

  # Attach the same records to both created zones
  records = [
    {
      type = "A"
      ttl  = 3600
      records = [
        "172.217.16.206",
        "172.217.18.163"
      ]
    },
    {
      type = "TXT"
      ttl  = 300
      records = [
        "Lorem ipsum"
      ]
    },
    {
      name = "testing"
      type = "A"
      ttl  = 3600
      records = [
        "172.217.16.111"
      ]
    },
  ]
}
