module "api" {
  source                     = "genstackio/api-lambda/aws"
  version                    = "0.10.3"
  name                       = var.name
  env                        = var.env
  lambda_arn                 = module.lambda.arn
  lambda_invoke_arn          = module.lambda.invoke_arn
  dns                        = var.dns
  dns_zone                   = var.dns_zone
  dns_alts                   = var.dns_alts
  forward_query_string       = var.forward_query_string
  forward_cookies            = var.forward_cookies
  price_class                = var.price_class
  geolocations               = var.geolocations
  accesslogs_s3_bucket       = var.accesslogs_s3_bucket
  functions                  = var.functions
  static_assets              = var.static_assets
  unmanaged_static_assets    = var.unmanaged_static_assets
  edge_lambdas               = var.edge_lambdas
  forwarded_headers          = var.forwarded_headers
  edge_lambdas_variables     = var.edge_lambdas_variables
  static_assets_functions    = var.static_assets_functions
  unmanaged_static_assets_functions = var.unmanaged_static_assets_functions
  static_assets_edge_lambdas = var.static_assets_edge_lambdas
  unmanaged_static_assets_edge_lambdas = var.unmanaged_static_assets_edge_lambdas
  default_ttl                = var.default_ttl
  min_ttl                    = var.min_ttl
  max_ttl                    = var.max_ttl
  compress                   = var.compress
  response_headers_policy    = var.response_headers_policy
  cache_policy               = var.cache_policy
  origin_request_policy      = var.origin_request_policy
  no_static_assets_bucket_policy = var.no_static_assets_bucket_policy
  error_responses            = var.error_responses
  errors_bucket              = var.errors_bucket
  protocol                   = var.protocol
  providers = {
    aws     = aws
    aws.acm = aws.acm
  }
}

module "lambda" {
  source             = "genstackio/lambda/aws"
  version            = "0.5.0"
  file               = var.package_file
  s3_bucket          = var.package_s3_bucket
  s3_key             = var.package_s3_key
  image              = var.package_image
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
  name               = local.lambda_name
  runtime            = var.runtime
  handler            = var.handler
  timeout            = var.timeout
  memory_size        = var.memory_size
  publish            = var.publish
  layers             = var.layers
  variables = merge(
    local.has_data_bucket ? {
      DATA_BUCKET_NAME = aws_s3_bucket.data[0].bucket,
      DATA_BUCKET_ARN  = aws_s3_bucket.data[0].arn,
    } : {},
    var.variables
  )
  policy_statements = concat(
    var.policy_statements,
    local.has_data_bucket
    ? [
      {
        actions   = ["s3:ListBucket"]
        resources = [aws_s3_bucket.data[0].arn]
        effect    = "Allow"
      },
      {
        actions   = ["s3:GetObject", "s3:Put*", "s3:GetObjectTagging", "s3:DeleteObject*"]
        resources = ["${aws_s3_bucket.data[0].arn}/*"]
        effect    = "Allow"
      },
    ]
    : [],
    local.has_parameters
    ? [{
      actions   = [
        "ssm:GetParameter",
        "ssm:GetParameters",
      ]
      resources =  [for name, parameter in module.parameters[0].parameters: parameter.arn]
      effect    = "Allow"
    }]
    : [],
  )
  architectures = var.architectures
}

resource "aws_s3_bucket" "data" {
  count  = local.has_data_bucket ? 1 : 0
  bucket = var.data_s3_bucket
}

resource "aws_s3_bucket_acl" "data" {
  count  = local.has_data_bucket ? 1 : 0
  bucket = aws_s3_bucket.data[0].id
  acl    = "private"
}

module "parameters" {
  count      = local.has_parameters ? 1 : 0
  source     = "genstackio/parameters/aws"
  version    = "0.3.0"
  parameters = var.parameters
}
