resource "aws_security_group" "security_group_app" {
  vpc_id = "${aws_vpc.vpc.id}"
  name   = "${var.application_name}-app"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}