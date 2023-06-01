if (Test-Path -Path ".aws") {
  docker build -t awstest-deployment -f Dockerfile.devenv .
  if ($?) { docker run -v "${PWD}:/root" -v "//var/run/docker.sock:/var/run/docker.sock" -it --privileged awstest-deployment }
} else {
  Write-Error -Message ".aws config folder not present in the root of the repo, please set it up!" -ErrorAction Stop
}
