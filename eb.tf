resource "aws_elastic_beanstalk_environment" "ng_beanstalk_application_environment_app" {
  name                = "${var.application_name}-app"
  application         = "${aws_elastic_beanstalk_application.ng_beanstalk_application.name}"
  cname_prefix        = "${var.application_name}-app"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.11.7 running Multi-container Docker 18.06.1-ce (Generic)"

  tier = "WebServer"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${aws_vpc.vpc.id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${aws_subnet.public_subnet_1a.id},${aws_subnet.public_subnet_1b.id}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${aws_iam_instance_profile.ng_beanstalk_ec2.name}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = "${aws_security_group.security_group_app.id}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "${var.ECS_INSTANCE_TYPE}"
  }

  setting {
    namespace = "aws:elb:listener"
    name      = "ListenerProtocol"
    value     = "HTTP"
  }

  setting {
    namespace = "aws:elb:listener"
    name      = "InstancePort"
    value     = "80"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "${var.AUTOSCALE_MIN}"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "${var.AUTOSCALE_MAX}"
  }
}
