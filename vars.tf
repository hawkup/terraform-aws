variable "AWS_REGION" {
  default = "ap-southeast-1"
}

variable "ENVIRONMENT" {
  default = "develop"
}

variable "application_name" {
  default = "hello-world"
}

variable "application_description" {
  default = "hello-world"
}

variable "KEY_PAIR" {
  default = "aws-hello-world"
}

variable "ECS_INSTANCE_TYPE" {
  default = "t2.small"
}

variable "AUTOSCALE_MIN" {
  default = "2"
}

variable "AUTOSCALE_MAX" {
  default = "2"
}
