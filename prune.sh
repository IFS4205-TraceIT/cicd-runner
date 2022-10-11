#!/bin/bash

# Delete all _work directories
for dir in "./github-runner-"*/
do
  [ -e "$dir/_work" ] && rm -rf "$dir/_work"
done

# Delete docker-related data
docker image prune -a -f
docker volume prune -f
