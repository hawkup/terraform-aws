provider "aws" {
  region = "${var.AWS_REGION}"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name        = "${var.ENVIRONMENT}-vpc"
    Environment = "${var.ENVIRONMENT}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.ENVIRONMENT}-internet-gateway"
    Environment = "${var.ENVIRONMENT}"
  }
}

resource "aws_eip" "eip" {
  vpc        = true
  depends_on = ["aws_internet_gateway.internet_gateway"]

  tags {
    Name        = "${var.ENVIRONMENT}-eip"
    Environment = "${var.ENVIRONMENT}"
  }
}
