output "endpoint" {
  value = module.api.endpoint
}
output "internal_endpoint" {
  value = module.api.internal_endpoint
}
output "dispatch_endpoint" {
  value = var.protocol == "WEBSOCKET" ? "${replace(module.api.internal_endpoint, "wss://", "https://")}/$default/@connections" : null
}
output "dispatch_execution_arn_pattern" {
  value = var.protocol == "WEBSOCKET" ? "${module.api.internal_execution_arn}/$default/POST/@connections/*" : null
}
output "lambda_arn" {
  value = module.lambda.arn
}
output "lambda_invoke_arn" {
  value = module.lambda.invoke_arn
}
output "lambda_name" {
  value = module.lambda.name
}
output "lambda_role_name" {
  value = module.lambda.role_name
}
output "data_bucket_name" {
  value = local.has_data_bucket ? aws_s3_bucket.data[0].bucket : null
}
output "data_bucket_arn" {
  value = local.has_data_bucket ? aws_s3_bucket.data[0].arn : null
}
output "static_assets_buckets" {
  value = module.api.static_assets_buckets
}
output "cloudfront_id" {
  value = module.api.cloudfront_id
}
output "cloudfront_arn" {
  value = module.api.cloudfront_arn
}
output "cloudfront_origin_access_identity_iam_arn" {
  value = module.api.cloudfront_origin_access_identity_iam_arn
}
output "parameters" {
  value = local.has_parameters ? module.parameters[0].parameters : {}
}