#!/usr/bin/env bash


# Configuration
SOURCE_REPO=https://github.com/apache/flink.git
TARGET_REPO=https://github.com/flink-ci/flink-mirror.git

echo "Syncing branches"
# update last sync file
date > .last-sync


if [ ! -d ".repo" ]; then
	echo "SOURCE_REPO ($SOURCE_REPO) does not exist. Cloning ..."
	git clone --mirror $SOURCE_REPO .repo
fi

cd .repo

echo "Fetching from SOURCE_REPO ($SOURCE_REPO)"
git fetch

echo "Pushing to TARGET_REPO ($TARGET_REPO)"
git push -v --all $TARGET_REPO
