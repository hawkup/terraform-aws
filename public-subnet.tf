resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1a"

  tags {
    Name        = "${var.ENVIRONMENT}-public-subnet-1a"
    Environment = "${var.ENVIRONMENT}"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1b"

  tags {
    Name        = "${var.ENVIRONMENT}-public-subnet-1b"
    Environment = "${var.ENVIRONMENT}"
  }
}
