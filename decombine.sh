#!/bin/sh
user="`printenv USER`"
userFolder="pb$user.PB"
repoPathOnWsl="`pwd`"
repoName=${repoPathOnWsl##*/}
repoPathInDesktop="/mnt/c/Users/$userFolder/Desktop/$repoName"

# copy repo on WSL to Desktop
cp -rf ../$repoName $repoPathInDesktop
# move to repo in Desktop
cd $repoPathInDesktop
# decombine
cmd.exe /c cscript vbac.wsf decombine
# copy src/*/*.* of repo in Desktop to repo on WSL
cp -f ./src/*/*.* $repoPathOnWsl/src/*
# move to repo in on WSL
cd $repoPathOnWsl
# delete repo in Desktop
rm -rf $repoPathInDesktop

