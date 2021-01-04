#!/usr/bin/env bash
environment=$1

if [[ "$environment" != "integration" && "$environment" != "sandbox" && "$environment" != "production" ]]; then
    echo "Wrong parameter!"
    echo "Usage:"
    echo "$0 [integration|sandbox|production]"
    exit 1
fi

branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

if [[ $branch != "master" && "$environment" = "production" ]]; then
   echo "WARNING!! Use 'master' branch to production deploy"
   exit 1
fi

timestamp=$(date +%Y%m%d-%H%M%S)
tag=$environment-$timestamp

git tag $tag
git push origin $tag
