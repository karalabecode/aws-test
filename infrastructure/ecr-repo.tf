resource "aws_ecr_repository" "this" {
  name = "sample_api"
  force_delete = true
}