#!/bin/bash
# setting up prerequisites
elasticsearch-plugin install analysis-icu repository-s3
exec /usr/local/bin/entrypoint.sh.SAV elasticsearch

