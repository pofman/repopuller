#!/bin/bash

excludedFolders=()
baseDir=${PWD}
baseDir="$baseDir/"
baseDirLength=${#baseDir}

if [ -f excludeFoldersi.txt ]; then
    while IFS='' read -r line || [[ -n "$line" ]]; do
        excludedFolders+=("$line")
    done < "excludeFolders.txt"
fi

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
