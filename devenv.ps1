docker build -t awstest-deployment -f Dockerfile.devenv .
if ($?) { docker run -v "${PWD}:/root" -v "//var/run/docker.sock:/var/run/docker.sock" -it --privileged awstest-deployment }
