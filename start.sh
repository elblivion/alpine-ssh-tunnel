#!/bin/sh

ssh-keyscan -p $SSH_PORT $SSH_HOST >> ~/.ssh/known_hosts

if [ ! -z "$SSH_KEY" ]; then
  echo "$SSH_KEY" > $ID_FILE
  chmod 600 $ID_FILE
fi

if [ ! -z "$DEBUG" ]; then
  EXTRA_FLAGS="$EXTRA_FLAGS -v"
fi

ssh -i ${ID_FILE} \
  -p ${SSH_PORT} \
  $EXTRA_FLAGS \
  -L $LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT \
  $SSH_USER@$SSH_HOST
