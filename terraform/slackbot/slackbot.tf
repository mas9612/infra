resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_role_policy" {
  name = "lambda_role_policy"
  policy = "${templatefile("templates/lambda_role_policy.tpl", { aws_account_id = "${var.aws_account_id}" })}"
}

resource "aws_iam_policy_attachment" "lambda_role_attachment" {
  name = "lambda_role_attachment"
  roles = ["${aws_iam_role.lambda_role.name}"]
  policy_arn = "${aws_iam_policy.lambda_role_policy.arn}"
}

resource "aws_lambda_function" "lambda_slackbot" {
  filename = "slackbot.zip"
  function_name = "slackbot"
  role = "${aws_iam_role.lambda_role.arn}"
  handler = "slackbot"

  memory_size = "128"

  source_code_hash = "${filebase64sha256("slackbot.zip")}"

  runtime = "go1.x"

  environment {
    variables = {
      "SLACK_VERIFICATION_TOKEN" = "${var.slack_verification_token}"
    }
  }
}

resource "aws_api_gateway_rest_api" "slackbot" {
  name = "Slackbot"
  description = "API Gateway for personal Slackbot"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "slackbot" {
  rest_api_id = "${aws_api_gateway_rest_api.slackbot.id}"
  parent_id = "${aws_api_gateway_rest_api.slackbot.root_resource_id}"
  path_part = "event"
}

resource "aws_api_gateway_method" "slackbot_post" {
  rest_api_id = "${aws_api_gateway_rest_api.slackbot.id}"
  resource_id = "${aws_api_gateway_resource.slackbot.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "slackbot" {
  rest_api_id = "${aws_api_gateway_rest_api.slackbot.id}"
  resource_id = "${aws_api_gateway_resource.slackbot.id}"
  http_method = "${aws_api_gateway_method.slackbot_post.http_method}"
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_slackbot.arn}/invocations"
}

resource "aws_lambda_permission" "slackbot" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_slackbot.function_name}"
  principal = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.slackbot.id}/*/${aws_api_gateway_method.slackbot_post.http_method}${aws_api_gateway_resource.slackbot.path}"
}

resource "aws_api_gateway_deployment" "slackbot" {
  depends_on = ["aws_api_gateway_integration.slackbot"]

  rest_api_id = "${aws_api_gateway_rest_api.slackbot.id}"
  stage_name = "bot"
}
