#!/bin/bash
set -e

function LogInfo() { echo -e "\033[32m[info] $1\033[0m"; }
function LogError() { echo -e "\033[31m[error] $1\033[0m"; }
# function LogWarn() { echo -e "\033[33m[warning] $1\033[0m"; }
# function LogDebug() { echo -e "\033[37m[debug] $1\033[0m"; }

webcontent=$(curl -A "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)" -s 'https://www.minecraft.net/en-us/download/server/bedrock')
NEW_VERSION=$(echo $webcontent | grep "https://minecraft.azureedge.net/bin-linux/bedrock-server-" | sed 's/^.*bedrock-server-//g' | sed 's/.zip.*$//g')

REPO_PATH=.
version_reg='^1(\.[0-9]+){3}$'

LogInfo "get newest version: $NEW_VERSION"
if [[ ! "$NEW_VERSION" =~ $version_reg ]]; then
  LogError 'get NEW_VERSION ERROR, exit'
  exit
fi

OLD_VERSION=$(cat ${REPO_PATH}/VERSION)

if [[ ! "$OLD_VERSION" =~ $version_reg ]]; then
  LogError 'get OLD_VERSION ERROR, exit'
  exit
fi

if [[ "${OLD_VERSION}" == "${NEW_VERSION}" ]]; then
  LogInfo "current version is newest"
  exit
else
  LogInfo "updating ${OLD_VERSION} => ${NEW_VERSION}"
fi

sed -i "s/$OLD_VERSION/$NEW_VERSION/g" $REPO_PATH/Dockerfile
sed -i "s/$OLD_VERSION/$NEW_VERSION/g" $REPO_PATH/readme.md
sed -i "s/$OLD_VERSION/$NEW_VERSION/g" $REPO_PATH/readme_zh.md
sed -i "s/$OLD_VERSION/$NEW_VERSION/g" $REPO_PATH/VERSION

# LogInfo "push update"
# cd $REPO_PATH
# git add . && git commit -am "update to $NEW_VERSION"
# git push

# LogInfo "push tag"
# git tag $NEW_VERSION
# git push --tag

# # for github action
RELEASE_VERSION=${NEW_VERSION}
# RELEASE_VERSION=dev
RELEASE_VERSION=debug
LogInfo "debug mode $RELEASE_VERSION"
echo "RELEASE_VERSION=$RELEASE_VERSION" >>$GITHUB_ENV
