## ECS instance AMI profiles


variable "ecs_instance_role_extra_policies" {
  default = []
}

resource "aws_iam_role" "ecs_instance" {
  name = "ecsInstanceRole"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
            "Service": ["ec2.amazonaws.com"]
        },
        "Action": ["sts:AssumeRole"]
      }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "ecs_instance" {
  name = "ecsInstanceProfile"
  roles = ["${aws_iam_role.ecs_instance.name}"]
}

resource "aws_iam_policy_attachment" "ecs_instance_role_attachments" {
  count = "${length(var.ecs_instance_role_extra_policies)}"
  name = "ecsInstanceAttachment${count.index}"
  roles = ["${aws_iam_role.ecs_instance.name}"]
  policy_arn = "${element(var.ecs_instance_role_extra_policies, count.index)}"
}

resource "aws_iam_role" "ecs_service" {
  name = "ecsServiceRole"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Principal": {
            "Service": ["ecs.amazonaws.com"]
        },
        "Action": ["sts:AssumeRole"]
    }]
}
EOF
}

# Output variables
output "instance_profile" {
    value = "${aws_iam_instance_profile.ecs_instance}"
}

output "instance_role" {
    value = "${aws_iam_role.ecs_instance}"
}

output "service_role" {
    value = "${aws_iam_role.ecs_service}"
}
