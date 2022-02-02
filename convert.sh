#!/bin/bash

# Note that this does not use pipefail
# because if the grep later doesn't match any deleted files,
# which is likely the majority case,
# it does not exit with a 0, and I only care about the final exit.
set -eo

sudo wget https://github.com/wpreadme2markdown/wp2md/releases/latest/download/wp2md.phar -O /usr/local/bin/wp2md
sudo chmod a+x /usr/local/bin/wp2md

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

wp2md -i readme.txt -o README.md

git add README.md
git commit -m "Updated Readme"
git remote set-url origin "https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git push origin

echo "✓ Readme Converted!"
