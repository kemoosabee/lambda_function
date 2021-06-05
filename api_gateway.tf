resource "aws_api_gateway_rest_api" "functions" {
  name        = "Math"
  description = "Terraform Serverless Functions"
}

resource "aws_api_gateway_resource" "sum_proxy_resource" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   parent_id   = aws_api_gateway_rest_api.functions.root_resource_id
   path_part   = "sum"
}

//new 
resource "aws_api_gateway_resource" "sub_proxy_resource" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   parent_id   = aws_api_gateway_rest_api.functions.root_resource_id
   path_part   = "sub"
}

resource "aws_api_gateway_method" "sum_proxy_method" {
   rest_api_id   = aws_api_gateway_rest_api.functions.id
   resource_id   = aws_api_gateway_resource.sum_proxy_resource.id
   http_method   = "ANY"
   authorization = "NONE"
}

//new
resource "aws_api_gateway_method" "sub_proxy_method" {
   rest_api_id   = aws_api_gateway_rest_api.functions.id
   resource_id   = aws_api_gateway_resource.sub_proxy_resource.id
   http_method   = "ANY"
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "sum" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.sum_proxy_method.resource_id
   http_method = aws_api_gateway_method.sum_proxy_method.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.sum.invoke_arn
}

//new
resource "aws_api_gateway_integration" "sub" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.sub_proxy_method.resource_id
   http_method = aws_api_gateway_method.sub_proxy_method.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.sub.invoke_arn
}


resource "aws_api_gateway_method" "proxy_root" {
   rest_api_id   = aws_api_gateway_rest_api.functions.id
   resource_id   = aws_api_gateway_rest_api.functions.root_resource_id
   http_method   = "ANY"
   authorization = "NONE"
}


resource "aws_api_gateway_integration" "sum_lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.sum.invoke_arn
}

//new
resource "aws_api_gateway_integration" "sub_lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.sub.invoke_arn
}

resource "aws_api_gateway_deployment" "sum" {
   depends_on = [
     aws_api_gateway_integration.sum,
     aws_api_gateway_integration.sum_lambda_root,

   ]

   rest_api_id = aws_api_gateway_rest_api.functions.id
   stage_name  = "math"
}

//new
resource "aws_api_gateway_deployment" "sub" {
   depends_on = [
     aws_api_gateway_integration.sub,
     aws_api_gateway_integration.sub_lambda_root,

   ]

   rest_api_id = aws_api_gateway_rest_api.functions.id
   stage_name  = "math"
}
