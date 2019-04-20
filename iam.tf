resource "aws_iam_instance_profile" "ng_beanstalk_ec2" {
  name = "${var.application_name}-beanstalk-ec2-user"
  role = "${aws_iam_role.ng_beanstalk_ec2.name}"
}

resource "aws_iam_role" "ng_beanstalk_ec2" {
  name = "${var.application_name}-beanstalk-ec2-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ng_beanstalk_ec2_policy" {
  name = "${var.application_name}_beanstalk_ec2_policy_with_ECR"
  role = "${aws_iam_role.ng_beanstalk_ec2.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudwatch:PutMetricData",
        "ds:CreateComputer",
        "ds:DescribeDirectories",
        "ec2:DescribeInstanceStatus",
        "logs:*",
        "ssm:*",
        "ec2messages:*",
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eb-ecr-readonly-attach" {
  role       = "${aws_iam_role.ng_beanstalk_ec2.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "eb-web-tier-attach" {
  role       = "${aws_iam_role.ng_beanstalk_ec2.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "eb-ecs-attach" {
  role       = "${aws_iam_role.ng_beanstalk_ec2.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_elastic_beanstalk_application" "ng_beanstalk_application" {
  name        = "${var.application_name}"
  description = "${var.application_description}"
}
