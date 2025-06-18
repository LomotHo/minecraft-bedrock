 #!/bin/bash
set -e

function LogInfo() { echo -e "\033[32m[info] $1\033[0m"; }
function LogError() { echo -e "\033[31m[error] $1\033[0m"; }
function LogWarn() { echo -e "\033[33m[warning] $1\033[0m"; }
# function LogDebug() { echo -e "\033[37m[debug] $1\033[0m"; }

# webcontent=$(curl -A "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)" -s 'https://www.minecraft.net/en-us/download/server/bedrock')
# NEW_VERSION=$(echo "$webcontent" | grep "bin-linux/bedrock-server-" | sed 's/^.*bedrock-server-//g' | sed 's/.zip.*$//g')
links_data=$(curl "https://net-secondary.web.minecraft-services.net/api/v1.0/download/links")
echo $links_data
NEW_VERSION=$(echo "$links_data" | grep "bin-linux/bedrock-server-" | sed 's/^.*bin-linux\/bedrock-server-//g' | sed 's/.zip.*$//g')

LogInfo "get newest version: $NEW_VERSION"
REPO_PATH=.
OLD_VERSION=$(cat ${REPO_PATH}/VERSION)
version_reg='^1(\.[0-9]+){3}$'

# # NEW_VERSION="debug"
# LogWarn "debug mode"
# echo "HAS_UPDATE=true" >>$GITHUB_ENV
# echo "RELEASE_VERSION=d114514" >>$GITHUB_ENV
# exit 0

if [[ ! "$NEW_VERSION" =~ $version_reg ]]; then
  LogError 'get NEW_VERSION ERROR, exit'
  exit 1
elif [[ ! "$OLD_VERSION" =~ $version_reg ]]; then
  LogError 'get OLD_VERSION ERROR, exit'
  exit 1
elif [[ "${OLD_VERSION}" == "${NEW_VERSION}" ]]; then
  LogInfo "current version is newest"
  # echo "PUBLISH_IMAGE=true" >>$GITHUB_ENV
  exit 0
else
  LogInfo "updating ${OLD_VERSION} => ${NEW_VERSION}"
  sed -i "s/$OLD_VERSION/$NEW_VERSION/g" $REPO_PATH/Dockerfile
  sed -i "s/$OLD_VERSION/$NEW_VERSION/g" $REPO_PATH/readme.md
  sed -i "s/$OLD_VERSION/$NEW_VERSION/g" $REPO_PATH/readme_zh.md
  sed -i "s/$OLD_VERSION/$NEW_VERSION/g" $REPO_PATH/VERSION
fi

# # for github action
echo "HAS_UPDATE=true" >>$GITHUB_ENV
echo "RELEASE_VERSION=$NEW_VERSION" >>$GITHUB_ENV
