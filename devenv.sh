([ -d .aws ] || (echo ".aws config folder not present in the root of the repo, please set it up!" 1>&2 && exit 1)) &&

docker build -t awstest-deployment -f Dockerfile.devenv . &&
  docker run -v "${PWD}:/root" -v "//var/run/docker.sock:/var/run/docker.sock" -it --privileged awstest-deployment
