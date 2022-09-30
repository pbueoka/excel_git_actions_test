#!/bin/sh
user="`printenv USER`"
userFolder="pb$user.PB"
repoPathOnWsl="`pwd`"
repoName=${repoPathOnWsl##*/}
repoPathInDesktop="/mnt/c/Users/$userFolder/Desktop/$repoName"

# check ExcelVBA diff exists (If so, end processing.)
git diff --exit-code --quiet ./bin
if [ $? -eq 1 ]; then
    echo 'Cannot combine! (Diff exists in ExcelVBA. You may overwrite pre-decombined ExcelVBA!)'
    return 0
fi

# copy repo on WSL to Desktop
cp -rf ../$repoName $repoPathInDesktop
# move to repo in Desktop
cd $repoPathInDesktop
# combine
cmd.exe /c cscript vbac.wsf combine
# copy ExcelVBA of repo in Desktop to repo on WSL
cp -f ./bin/*.xlsm $repoPathOnWsl/bin
# move to repo in on WSL
cd $repoPathOnWsl
# delete repo in Desktop
rm -rf $repoPathInDesktop

