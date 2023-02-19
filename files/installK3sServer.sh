#!/bin/bash

until (curl -sfL https://get.k3s.io | sh -); do
  echo 'Waiting for k3s installation'
  sleep 3
done

until kubectl get pods -A | grep 'Running';
do
  echo 'Waiting for k3s server to initialize'
  sleep 5
done

touch /tmp/serverInitComplete
