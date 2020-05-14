#!/bin/ash

set -e

echo "$(date) - Start"

aws s3 sync /data s3://$BUCKET $PARAMS

echo "$(date) End"