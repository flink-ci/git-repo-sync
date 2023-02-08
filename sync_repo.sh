#!/usr/bin/env bash


# Configuration
SOURCE_REPO=https://github.com/apache/flink.git
TARGET_REPO=https://github.com/flink-ci/flink-mirror.git
TARGET_BRANCHES="master"

echo "Syncing branches"
# update last sync file
date > .last-sync


if [ ! -d ".repo" ]; then
	echo "SOURCE_REPO ($SOURCE_REPO) does not exist. Cloning ..."
	git clone --mirror $SOURCE_REPO .repo
        cd .repo
else
	# update list of current branches
        cd .repo
	git fetch origin 'refs/heads/release-*:refs/release-*'
fi

# echo "Fetching from SOURCE_REPO ($SOURCE_REPO)"
# git fetch origin master

for RELEASE_BRANCH in `git branch -a | grep "release-" | grep -v "rc" | sort -V -r | head -n 2` ; do
	TARGET_BRANCHES+=" $RELEASE_BRANCH"
done

echo "Fetching branches '$TARGET_BRANCHES' from SOURCE_REPO ($SOURCE_REPO)"
git fetch origin $TARGET_BRANCHES

echo "Pushing branches '$TARGET_BRANCHES' to TARGET_REPO ($TARGET_REPO)"

# generating refspec
REFSPEC=""
for TARGET_BRANCH in $TARGET_BRANCHES ; do
	REFSPEC+="$TARGET_BRANCH:$TARGET_BRANCH "
done

git push $TARGET_REPO $REFSPEC
