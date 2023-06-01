export REPO_NAME=sample_api
docker build --rm --pull -f src/AwsTest/Dockerfile -t $REPO_NAME src &&
docker run -p 80:80 $REPO_NAME
