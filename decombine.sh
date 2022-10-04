#!/bin/sh

# Cドライブのユーザフォルダのパスを取得
# 　※作者の環境では、%USERNAME%と%USERPROFILE%でユーザフォルダ名が異なった。
# 　※CRが含まれるのでsedで排除しておく。
userFolderPath="`cmd.exe /c echo %USERPROFILE% | sed 's/\r//g'`"
# ユーザフォルダ名を取得
# 　※ここでは、%USERPROFILE%の結果をもとにユーザフォルダ名を取得している。
userFolderName=${userFolderPath##*\\}
# リポジトリのパスを取得
repoPath="`pwd`"
# リポジトリ名を取得
repoName=${repoPath##*/}
# Cドライブのデスクトップにリポジトリをディレクトリごとコピーする時のパス
copyToPath="/mnt/c/Users/${userFolderName}/Desktop/${repoName}"

# Cドライブのデスクトップにリポジトリをディレクトリごとコピー
cp -rf ../$repoName $copyToPath
# コピー先のディレクトリに移動
cd $copyToPath
# デコンバイン実行
cmd.exe /c cscript vbac.wsf decombine
# デコンバイン後のsrc/{Excelマクロ名}にある全ファイルを、
# リポジトリのsrc/{Excelマクロ名}に上書きコピー
cp -f ./src/*/*.* $repoPath/src/*

# # 注！：万が一、copyToPathが誤っていたら大変なことになるのでコメントアウト。
# # 　　　デスクトップに作成されたフォルダは手で消そう。
# # 　　　　→　変数repoNameの宣言ミスにより、作者はデスクトップフォルダを吹き飛ばしました。。。
# # コピー先のディレクトリを削除
# rm -rf $copyToPath
