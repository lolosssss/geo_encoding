#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# navigaet to dist folder
cd dist

git init
git add -A
git commit -m "deploy"

git push -f git@github.com:lolosssss/geo_encoding.git main:gh-pages

cd -
