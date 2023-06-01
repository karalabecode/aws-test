data "aws_vpc" "this" {
  default = true
}
data "aws_subnets" "this" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}
data "aws_ecr_repository" "this" {
  name = "sample_api"
}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}