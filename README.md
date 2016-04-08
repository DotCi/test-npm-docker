## test-npm-docker [![Build Status](https://xxx/job/DotCi/job/test-npm-docker/badge/icon)](https://xxx/job/DotCi/job/test-npm-docker/)
====

Demonstrate how to setup [DotCi](http://groupon.github.io/DotCi/user-guide/DockerCompose/) [docker-compose](https://docs.docker.com/compose/) build-type for npm originally based on https://nodejs.org/en/docs/guides/nodejs-docker-webapp

One-time __/configure__ your DotCi project to enable __Build Options: Build Tags__ to publish the build's docker server image when the repo is tagged. This transition provides an easy lookup between DOTCI/job/org/job/repo <=> GITHUB/org/repo/tree/tag <=> DOCKER/org/repo:tag

#### develop locally
```
$ npm install -g npm@latest-2
$ npm install
$ npm start &
> docker-centos-hello@0.0.1 start xxx/test-npm-docker
> node index.js

Running on http://localhost:8080

$ curl -s http://localhost:8080
Hello world

$ fg
npm start
^C
```

#### local docker testing
```
$ docker-compose up build
...
Successfully built 13071124222a
test uses an image, skipping

$ docker-compose up test
Recreating testnpmdocker_server_1
Recreating testnpmdocker_test_1
Attaching to testnpmdocker_test_1
test_1    | + '[' true ']'
test_1    | + curl -s http://server:8080
test_1    | + grep 'Hello world'
test_1    | + sleep 5
test_1    | + '[' true ']'
test_1    | + curl -s http://server:8080
test_1    | + grep 'Hello world'
test_1    | Hello world
test_1    | + exit 0
testnpmdocker_test_1 exited with code 0

$ docker-compose ps
         Name                       Command               State             Ports
------------------------------------------------------------------------------------------
testnpmdocker_server_1   npm start                        Up       0.0.0.0:32768->8080/tcp
testnpmdocker_test_1     bash -cex while [ true ];  ...   Exit 0

$ curl -s http://localhost:32768
Hello world

$ docker-compose stop server
Stopping testnpmdocker_server_1 ... done

$ docker-compose rm -vf --all
Going to remove testnpmdocker_test_1
Removing testnpmdocker_test_1 ... done
```
