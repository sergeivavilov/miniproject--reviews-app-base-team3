resource "aws_s3_bucket" "mini_project_23d" {
  bucket = var.bucket
}

/* bucket_policy */

resource "aws_s3_bucket_policy" "mini_project_23d_policy" {
  depends_on = [aws_s3_object.maintenance_page]
  bucket     = var.bucket

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : [
          "arn:aws:s3:::${var.bucket}/*"
        ]
      }
    ]
  })
}

/* website_configuration */

resource "aws_s3_bucket_website_configuration" "mini_project_config" {
  bucket = aws_s3_bucket.mini_project_23d.id

  index_document {
    suffix = "index.html"
  }
}

/* ownership_controls */

resource "aws_s3_bucket_ownership_controls" "mini_project_23d_ownership" {
  bucket = aws_s3_bucket.mini_project_23d.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


/* public_access_block */

resource "aws_s3_bucket_public_access_block" "mini_project_23d_public_access" {
  bucket = aws_s3_bucket.mini_project_23d.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

/* Set ACL */

resource "aws_s3_bucket_acl" "mini_project_23d_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.mini_project_23d_ownership,
    aws_s3_bucket_public_access_block.mini_project_23d_public_access
  ]

  bucket = aws_s3_bucket.mini_project_23d.id
  acl    = "public-read"
}

/* s3_object */

resource "aws_s3_object" "maintenance_page" {
  bucket       = aws_s3_bucket.mini_project_23d.id
  key          = "index.html"
  source       = var.source_path
  content_type = "text/html"


}
resource "aws_s3_object" "maintenance_image" {
  bucket       = aws_s3_bucket.mini_project_23d.id
  key          = "main.jpg"
  source       = var.source_image_path
  content_type = "image/jpg"

}
