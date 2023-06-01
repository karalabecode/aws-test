resource "aws_ecs_service" "my_first_service" {
  name            = "my-first-service"               # Naming our first service
  cluster         = aws_ecs_cluster.this.id          # Referencing our created Cluster
  task_definition = aws_ecs_task_definition.this.arn # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = 3 # Setting the number of containers we want deployed to 3
  
  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn # Referencing our target group
    container_name   = aws_ecs_task_definition.this.family
    container_port   = 80 # Specifying the container port
  }

  network_configuration {
    subnets          = data.aws_subnets.this.ids
    assign_public_ip = true # Providing our containers with public IPs
  }
}
