# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "service_catalog_portfolio_ids" {
  type        = list(string)
  description = "ID of the AWS Service Catalog Portfolios to assign the product to"
}

locals {
  unique_portfolio_ids = { for index, portfolio_id in var.service_catalog_portfolio_ids : index => portfolio_id }
}

variable "service_catalog_product_owner" {
  type        = string
  description = "Name of the owner of the AWS Service Catalog Product"
  default     = "Service Catalog Admin"
}

variable "tfc_provider_arn" {
  type        = string
  description = "ARN of the AWS IAM OpenID Connect Provider that establishes trust with TFC"
}

variable "tfc_hostname" {
  type        = string
  description = "TFC hostname (defaults to TFC: app.terraform.io)"
  default     = "app.terraform.io"
}

variable "tfc_organization" {
  type        = string
  description = "Name of the organization to manage infrastructure within TFC"
}

variable "parameter_parser_role_arn" {
  type        = string
  description = "ARN of the IAM Role that the Terraform Parameter Parser Lambda Function uses to parse parameters"
}

variable "send_apply_lambda_role_arn" {
  type        = string
  description = "ARN of the IAM Role that the Send Apply Lambda Function uses to trigger applies in Terraform Cloud"
}
