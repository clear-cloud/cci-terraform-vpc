resource "aws_flow_log" "vpc" {
  count           = var.vpc_enable_flow_logs
  iam_role_arn    = aws_iam_role.cloudwatch_publish[0].arn
  log_destination = aws_cloudwatch_log_group.flow_log[0].arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
}

resource "aws_cloudwatch_log_group" "flow_log" {
  count = var.vpc_enable_flow_logs
  name  = "/aws/vpc/${var.environment}"
}

resource "aws_iam_role" "cloudwatch_publish" {
  count = var.vpc_enable_flow_logs
  name  = "${var.environment}.flow_log_publish.role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "cloudwatch_publish" {
  count = var.vpc_enable_flow_logs
  name = "${var.environment}.flow_log_publish.policy"
  role = aws_iam_role.cloudwatch_publish[0].id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}

