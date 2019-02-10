#!/bin/bash
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image=reddit-base-1547582274 \
  --image-project=infra-226316 \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
