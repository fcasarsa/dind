# dind

Simple docker in docker image to be used with [balena](https://balena.io)

* $Env:DOCKER_BUILDKIT="1"
* docker build -t dind .
* balena deploy <appname> dind