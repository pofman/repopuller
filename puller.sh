#!/bin/bash

excludedFolders=()
baseDir=${PWD}
baseDirLength=${#baseDir}

while IFS='' read -r line || [[ -n "$line" ]]; do
    excludedFolders+=("$line")
done < "excludeFolders.txt"

for repoDir in $baseDir*/
do
	echo $repoDir
	if echo ${excludedFolders[@]} | grep -q -w "${repoDir:baseDirLength}"; then 
		echo "Pull excluded"

	else 
		cd $repoDir
		git fetch origin -p
		actualBranch=`git branch | grep "*" | awk '{ print $2 }'`
		git pull origin $actualBranch
	fi
	echo ""
done
