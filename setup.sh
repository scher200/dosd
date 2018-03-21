#!/bin/bash

: ${DOCKERD_CMD:="dockerd --log-level 'fatal' > /dev/null 2>&1 &"}
: ${CUSTOM_CMD:="echo ok"}
: ${GIT_REPO:="https://github.com/openfaas/faas"}
: ${GIT_BRANCH:="0.7.1"}
: ${DEPLOY_STACK:="./deploy_stack.sh"}

bash -c "$DOCKERD_CMD" &

sleep 3 && docker swarm init && ${CUSTOM_CMD}

git clone -v $GIT_REPO repo \
 && cd repo \
 && git checkout $GIT_BRANCH \
 && $DEPLOY_STACK

exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
