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

//new
resource "aws_api_gateway_resource" "mult_proxy_resouce" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   parent_id   = aws_api_gateway_rest_api.functions.root_resource_id
   path_part   = "mult"
}

//new
resource "aws_api_gateway_resource" "divide_proxy_resouce" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   parent_id   = aws_api_gateway_rest_api.functions.root_resource_id
   path_part   = "divide"
}

//new
resource "aws_api_gateway_resource" "modulus_proxy_resouce" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   parent_id   = aws_api_gateway_rest_api.functions.root_resource_id
   path_part   = "modulus"
}

//new
resource "aws_api_gateway_resource" "square_proxy_resouce" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   parent_id   = aws_api_gateway_rest_api.functions.root_resource_id
   path_part   = "square"
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

//new
resource "aws_api_gateway_method" "mult_proxy_method" {
   rest_api_id   = aws_api_gateway_rest_api.functions.id
   resource_id   = aws_api_gateway_resource.mult_proxy_resouce.id
   http_method   = "ANY"
   authorization = "NONE"
}

//new
resource "aws_api_gateway_method" "divide_proxy_method" {
   rest_api_id   = aws_api_gateway_rest_api.functions.id
   resource_id   = aws_api_gateway_resource.divide_proxy_resouce.id
   http_method   = "ANY"
   authorization = "NONE"
}

//new
resource "aws_api_gateway_method" "modulus_proxy_method" {
   rest_api_id   = aws_api_gateway_rest_api.functions.id
   resource_id   = aws_api_gateway_resource.modulus_proxy_resouce.id
   http_method   = "ANY"
   authorization = "NONE"
}

//new
resource "aws_api_gateway_method" "square_proxy_method" {
   rest_api_id   = aws_api_gateway_rest_api.functions.id
   resource_id   = aws_api_gateway_resource.square_proxy_resouce.id
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

//new
resource "aws_api_gateway_integration" "mult" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.mult_proxy_method.resource_id
   http_method = aws_api_gateway_method.mult_proxy_method.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.multiply.invoke_arn
}

//new
resource "aws_api_gateway_integration" "divide" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.divide_proxy_method.resource_id
   http_method = aws_api_gateway_method.divide_proxy_method.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.divide.invoke_arn
}

//new
resource "aws_api_gateway_integration" "modulus" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.modulus_proxy_method.resource_id
   http_method = aws_api_gateway_method.modulus_proxy_method.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.modulus.invoke_arn
}

//new
resource "aws_api_gateway_integration" "square" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.square_proxy_method.resource_id
   http_method = aws_api_gateway_method.square_proxy_method.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.square.invoke_arn
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

//new
resource "aws_api_gateway_integration" "mult_lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.multiply.invoke_arn
}

//new
resource "aws_api_gateway_integration" "divide_lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.divide.invoke_arn
}

//new
resource "aws_api_gateway_integration" "modulus_lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.modulus.invoke_arn
}

//new
resource "aws_api_gateway_integration" "square_lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.functions.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.square.invoke_arn
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

//new
resource "aws_api_gateway_deployment" "mult" {
   depends_on = [
     aws_api_gateway_integration.mult,
     aws_api_gateway_integration.mult_lambda_root,

   ]

   rest_api_id = aws_api_gateway_rest_api.functions.id
   stage_name  = "math"
}

//new
resource "aws_api_gateway_deployment" "divide" {
   depends_on = [
     aws_api_gateway_integration.divide,
     aws_api_gateway_integration.divide_lambda_root,

   ]

   rest_api_id = aws_api_gateway_rest_api.functions.id
   stage_name  = "math"
}

//new
resource "aws_api_gateway_deployment" "modulus" {
   depends_on = [
     aws_api_gateway_integration.modulus,
     aws_api_gateway_integration.modulus_lambda_root,

   ]

   rest_api_id = aws_api_gateway_rest_api.functions.id
   stage_name  = "math"
}

//new
resource "aws_api_gateway_deployment" "square" {
   depends_on = [
     aws_api_gateway_integration.square,
     aws_api_gateway_integration.square_lambda_root,

   ]

   rest_api_id = aws_api_gateway_rest_api.functions.id
   stage_name  = "math"
}


