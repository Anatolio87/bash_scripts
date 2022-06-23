#!/bin/sh

repositoryBranchVersion="v3.16"
echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/$repositoryBranchVersion/main" >> /etc/apk/repositories
echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/$repositoryBranchVersion/community" >> /etc/apk/repositories
echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/edge/testing" >> /etc/apk/repositories
apk update && apk upgrade

