terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
   region = "us-east-1"
}

resource "aws_lambda_function" "sum" {
   function_name = "Sum"

   # The bucket name as created earlier with "aws s3api create-bucket"
   s3_bucket = var.s3_bucket
   s3_key    = "v${var.app_version}/sum.zip"

   # "main" is the filename within the zip file (main.js) and "handler"
   # is the name of the property under which the handler function was
   # exported in that file.
   handler = "sum.handler"
   runtime = "nodejs14.x"

   role = aws_iam_role.lambda_exec.arn
}

//new
resource "aws_lambda_function" "sub" {
   function_name = "Sub"
   s3_bucket = var.s3_bucket
   s3_key    = "v${var.app_version}/sub.zip"

   handler = "sub.handler"
   runtime = "nodejs14.x"

   role = aws_iam_role.lambda_exec.arn

}

//new
resource "aws_lambda_function" "multiply" {
   function_name = "Multiply"
   s3_bucket = var.s3_bucket
   s3_key    = "v${var.app_version}/multiply.zip"

   handler = "multiply.handler"
   runtime = "nodejs14.x"

   role = aws_iam_role.lambda_exec.arn
}

//new
resource "aws_lambda_function" "divide" {
   function_name = "Divide"
   s3_bucket = var.s3_bucket
   s3_key    = "v${var.app_version}/divide.zip"

   handler = "divide.handler"
   runtime = "nodejs14.x"

   role = aws_iam_role.lambda_exec.arn
}

//new
resource "aws_lambda_function" "modulus" {
   function_name = "Modulus"
   s3_bucket = var.s3_bucket
   s3_key    = "v${var.app_version}/modulus.zip"

   handler = "modulus.handler"
   runtime = "nodejs14.x"

   role = aws_iam_role.lambda_exec.arn
}

//new
resource "aws_lambda_function" "square" {
   function_name = "Square"
   s3_bucket = var.s3_bucket
   s3_key    = "v${var.app_version}/square.zip"

   handler = "square.handler"
   runtime = "nodejs14.x"

   role = aws_iam_role.lambda_exec.arn
}

 # IAM role which dictates what other AWS services the Lambda function
 # may access.
resource "aws_iam_role" "lambda_exec" {
   name = "serverless_example_lambda"

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

resource "aws_lambda_permission" "apigw" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.sum.function_name
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   source_arn = "${aws_api_gateway_rest_api.functions.execution_arn}/*/*"
}

//new
resource "aws_lambda_permission" "sub_permission" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.sub.function_name
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   source_arn = "${aws_api_gateway_rest_api.functions.execution_arn}/*/*"
}

//new
resource "aws_lambda_permission" "mult_permission" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.multiply.function_name
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   source_arn = "${aws_api_gateway_rest_api.functions.execution_arn}/*/*"
}

//new
resource "aws_lambda_permission" "divide_permission" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.divide.function_name
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   source_arn = "${aws_api_gateway_rest_api.functions.execution_arn}/*/*"
}

//new
resource "aws_lambda_permission" "modulus_permission" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.modulus.function_name
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   source_arn = "${aws_api_gateway_rest_api.functions.execution_arn}/*/*"
}

//new
resource "aws_lambda_permission" "square_permission" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.square.function_name
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   source_arn = "${aws_api_gateway_rest_api.functions.execution_arn}/*/*"
}

output "sum_url" {
  value = aws_api_gateway_deployment.sum.invoke_url
}

output "sub_url" {
  value = aws_api_gateway_deployment.sub.invoke_url
}
