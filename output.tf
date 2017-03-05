output "instance_role" {
    value = "${aws_iam_role.ecs_instance.arn}"
}

output "instance_profile" {
  value = "${aws_iam_instance_profile.ecs_instance.arn}"
}

output "service_role" {
    value = "${aws_iam_role.ecs_service.arn}"
}
