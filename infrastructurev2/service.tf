provider "aws" {
  region  = "eu-central-1"
}

resource "aws_ecr_repository" "awesome-repo" {
  name = "awesome-repo"
}

resource "aws_ecs_cluster" "awesome-cluster" {
  name = "awesome-cluster"
}

resource "aws_ecs_service" "awesome-service" {
  name            = "awesome-service"
  cluster         = aws_ecs_cluster.awesome-cluster.id
  task_definition = aws_ecs_task_definition.awesome-task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = aws_ecs_task_definition.awesome-task.family
    container_port   = 80
  }

  network_configuration {
    subnets = [
      aws_default_subnet.default_subnet_a.id, aws_default_subnet.default_subnet_b.id,
      aws_default_subnet.default_subnet_c.id
    ]
    assign_public_ip = true
    security_groups  = [aws_security_group.service_security_group.id]
  }
}

resource "aws_ecs_task_definition" "awesome-task" {
  family                = "awesome-task"
  container_definitions = jsonencode([
    {
      name : "awesome-task",
      image : aws_ecr_repository.awesome-repo.repository_url,
      essential : true,
      portMappings : [
        {
          "containerPort" : 80,
          "hostPort" : 80
        }
      ],
      memory : 512,
      cpu : 256
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
}