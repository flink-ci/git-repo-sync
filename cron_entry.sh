#!/usr/bin/env bash

cd /home/robert/production/git-repo-sync
su robert
./sync_repo.sh 2>&1 | tee cron.log



