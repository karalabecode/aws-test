resource "aws_ecs_task_definition" "this" {
  family                   = data.aws_ecr_repository.this.name
  memory                   = 512
  cpu                      = 256
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.task.arn
  execution_role_arn       = aws_iam_role.task.arn
  network_mode             = "awsvpc"
  container_definitions = jsonencode(
    [{
      "name" : data.aws_ecr_repository.this.name
      "image" : data.aws_ecr_repository.this.repository_url,
      "portMappings" : [
        {
          containerPort = 80
          hostPort      = 80
        }
      ],
    }]
  )
}
