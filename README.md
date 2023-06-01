# aws-test
A playground repository to test terraform deployment of .net apps to aws

# requirements

 - docker

... and that's it!

To set up the dev environment run ./devenv.sh on linux (or .\devenv.ps1 on windows, and then welcome to linux!). There you can:
 - `./run.sh` to run the api locally, goto -> http://localhost
 - `./create.sh` to deploy to aws. Make sure you have the aws config files present:
   - $REPO_ROOT/.aws/config
   - $REPO_ROOT/.aws/credentials
 - `./destroy.sh` to destroy everything on aws

# sources
  - First I started with this: https://medium.com/@fran6_ca/how-to-deploy-a-net-core-api-to-aws-using-terraform-and-docker-9ba69ac065aa
  - Later I realised it is:
    - outdated (aws_subnet_ids)
    - not working (/WeatherForecast returns HTTP 503 that means "The target groups for the load balancer have no registered targets.")
  - So I updated the rest by this one: https://medium.com/avmconsulting-blog/how-to-deploy-a-dockerised-node-js-application-on-aws-ecs-with-terraform-3e6bceb48785
    - which is super old but whatever
