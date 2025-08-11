variable "env" {
  type = string
}
variable "name" {
  type = string
}
variable "dns" {
  type = string
}
variable "dns_zone" {
  type = string
}
variable "dns_alts" {
  type    = list(string)
  default = null
}
variable "package_file" {
  type    = string
  default = null
}
variable "package_s3_bucket" {
  type    = string
  default = null
}
variable "package_s3_key" {
  type    = string
  default = null
}
variable "package_image" {
  type    = string
  default = null
}
variable "subnet_ids" {
  type    = list(string)
  default = []
}
variable "security_group_ids" {
  type    = list(string)
  default = []
}
variable "no_static_assets_bucket_policy" {
  type    = bool
  default = false
}
variable "data_s3_bucket" {
  type    = string
  default = null
}
variable "runtime" {
  type    = string
  default = "nodejs16.x"
}
variable "timeout" {
  type    = number
  default = 29
}
variable "event_timeout" {
  type    = number
  default = 300
}
variable "memory_size" {
  type    = number
  default = 128
}
variable "handler" {
  type    = string
  default = "lambda.handler"
}
variable "event_handler" {
  type    = string
  default = "lambda.handler_event"
}
variable "variables" {
  type    = map(string)
  default = {}
}
variable "policy_statements" {
  type = list(
    object({
      actions   = list(string),
      resources = list(string),
      effect    = string
    })
  )
  default = []
}
variable "geolocations" {
  type    = list(string)
  default = []
}
variable "forward_query_string" {
  type    = bool
  default = null
}
variable "forward_cookies" {
  type    = bool
  default = null
}
variable "price_class" {
  type    = string
  default = "PriceClass_100"
}
variable "publish" {
  type    = bool
  default = null
}
variable "lambda_name" {
  type    = string
  default = null
}
variable "event_lambda_name" {
  type    = string
  default = null
}
variable "event_lambda" {
  type    = bool
  default = false
}
variable "accesslogs_s3_bucket" {
  type    = string
  default = null
}
variable "edge_lambdas" {
  type = list(object({
    event_type   = string
    lambda_arn   = string
    include_body = bool
  }))
  default = []
}
variable "edge_lambdas_variables" {
  type    = map(string)
  default = {}
}
variable "static_assets_edge_lambdas" {
  type = list(object({
    event_type   = string
    lambda_arn   = string
    include_body = bool
  }))
  default = []
}
variable "unmanaged_static_assets_edge_lambdas" {
  type = list(object({
    event_type   = string
    lambda_arn   = string
    include_body = bool
  }))
  default = []
}
variable "functions" {
  type = list(object({
    event_type   = optional(string)
    function_arn = optional(string) // deprecated, arn || function_arn
    arn          = optional(string)
    code         = optional(string) // function_arn || (code + name)
    name         = optional(string)
    full_name    = optional(string)
    runtime      = optional(string)
    kv_stores    = optional(list(string))
  }))
  default = []
}
variable "static_assets_functions" {
  type = list(object({
    event_type   = string
    function_arn = string
  }))
  default = []
}
variable "unmanaged_static_assets_functions" {
  type = list(object({
    event_type   = string
    function_arn = string
  }))
  default = []
}
variable "layers" {
  type    = list(string)
  default = []
}
variable "static_assets" {
  type = list(object({
    path_pattern = string
    id           = string
    bucket_id    = string
    bucket_name  = string
  }))
  default = []
}
variable "unmanaged_static_assets" {
  type = list(object({
    path_pattern = string
    id           = string
    bucket_id    = string
    bucket_name  = string
  }))
  default = []
}
variable "forwarded_headers" {
  type    = list(string)
  default = null
}
variable "min_ttl" {
  type    = number
  default = 0
}
variable "max_ttl" {
  type    = number
  default = 86400
}
variable "default_ttl" {
  type    = number
  default = 0
}
variable "compress" {
  type    = bool
  default = true
}
variable "response_headers_policy" {
  type    = string
  default = null
}
variable "cache_policy" {
  type    = string
  default = null
}
variable "origin_request_policy" {
  type    = string
  default = null
}
variable "error_responses" {
  type = list(object({
    code = number
    ttl = optional(number)
    response_code = optional(number)
    response_page_path = optional(string)
  }))
  default = []
}
variable "errors_bucket" {
  type = string
  default = null
}
variable "parameters" {
  type = list(object({
    secret = optional(bool)
    name = string
    default_value = optional(string)
  }))
  default = []
}
variable "architectures" {
  type    = string
  default = "x86_64"
}
variable "protocol" {
  type    = string
  default = "HTTP"
}
variable "tracing_mode" {
  type    = string
  default = null
}
