resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

resource "aws_route_table_association" "public_subnet_1a_association" {
  subnet_id      = "${aws_subnet.public_subnet_1a.id}"
  route_table_id = "${aws_vpc.vpc.main_route_table_id}"
}

resource "aws_route_table_association" "public_subnet_1b_association" {
  subnet_id      = "${aws_subnet.public_subnet_1b.id}"
  route_table_id = "${aws_vpc.vpc.main_route_table_id}"
}
