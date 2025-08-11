locals {
  lambda_name     = (null == var.lambda_name) ? "${var.env}-api-${var.name}" : var.lambda_name
  event_lambda_name = (null == var.event_lambda_name) ? "${local.lambda_name}-event" : var.event_lambda_name
  has_data_bucket = ("" != var.data_s3_bucket) && (null != var.data_s3_bucket)
  has_parameters  = length(var.parameters) > 0
}
