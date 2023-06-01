export ACCOUNT_NUMBER=$(aws sts get-caller-identity --query Account | sed 's/\"//g')
export AWS_DEFAULT_REGION=eu-central-1
export ECR_URL=$ACCOUNT_NUMBER.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com
export REPO_NAME=sample_api

([ $(cat .docker/config.json | jq '.auths | length') -ne '0' ] ||
  aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ECR_URL) &&

([ -d infrastructure/.terraform ] || terraform -chdir=infrastructure init) &&
  terraform -chdir=infrastructure validate &&
  terraform -chdir=infrastructure apply -target=aws_ecr_repository.this -auto-approve &&

docker build --rm --pull -f src/AwsTest/Dockerfile -t $REPO_NAME src &&
docker tag ${REPO_NAME}:latest ${ECR_URL}/${REPO_NAME}:latest &&
docker push ${ECR_URL}/${REPO_NAME}:latest &&

terraform -chdir=infrastructure apply -auto-approve
