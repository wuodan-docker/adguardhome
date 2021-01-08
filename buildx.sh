#!/bin/bash

set -e

APP_VERSION=0.104.3

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

docker buildx build \
	--platform linux/arm/v6 \
	--tag wuodan/adguardhome:"${APP_VERSION}" \
	--tag wuodan/adguardhome:latest \
	--build-arg APP_VERSION="${APP_VERSION}" \
	"${DIR}"

docker push wuodan/adguardhome:"${APP_VERSION}" 

docker push wuodan/adguardhome:latest

