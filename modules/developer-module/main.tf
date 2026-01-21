resource "aws_iam_group" "this" {
  name = var.group_name
}

resource "aws_iam_policy" "assume_role" {
  name   = "${var.group_name}AssumeRole"
  policy = data.template_file.assume_role.rendered
}

data "template_file" "assume_role" {
  template = <<TEMPLATE
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": "sts:AssumeRole",
    "Resource": ${roles_arns_json}
  }
}
TEMPLATE

  vars = {
    roles_arns_json = jsonencode(var.assume_role_arns)
  }
}

resource "aws_iam_group_policy_attachment" "assume_role" {
  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.assume_role.arn
}