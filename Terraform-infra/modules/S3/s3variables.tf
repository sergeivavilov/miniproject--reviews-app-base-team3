variable "bucket" {
  description = "S3 bucket maintenance name"
  type        = string
  default     = "S3-default-23d"
}

variable "source_path" {
  description = "Relative path for uploading file"
  type        = string
}

variable "source_image_path" {
  type = string
}
