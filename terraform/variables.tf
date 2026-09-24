variable "project_id" {
  description = "GCP project ID to deploy into."
  type        = string
}

variable "region" {
  description = "Region for regional resources (e.g. us-central1)."
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "bucket_name" {
  description = "Globally unique name for the private data bucket."
  type        = string
}

variable "bucket_labels" {
  description = "Extra labels for the bucket."
  type        = map(string)
  default     = {}
}

variable "bucket_reader_members" {
  description = "IAM principals granted read access, e.g. [\"group:data-team@example.com\"]."
  type        = list(string)
  default     = []
}
