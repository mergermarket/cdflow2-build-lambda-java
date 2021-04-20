#!/usr/bin/env bash
set -euxo pipefail # exit unset print pipefail
if [ "${1:-}" = "requirements" ]; then
  echo "{\"needs\":[\"lambda\"]}"
  exit
fi
cp -r /code /tmp
cd /tmp/code
GRADLE_OPTS=-Dorg.gradle.project.buildDir=/build gradle --no-daemon --gradle-user-home /tmp/gradle-user-home --project-cache-dir /tmp/gradle-project-cache-dir buildZip
aws s3 cp /build/distributions/executable.zip "s3://${LAMBDA_BUCKET}/${LAMBDA_PATH}"
echo "{\"bucket\":\"${LAMBDA_BUCKET}\",\"key\":\"${LAMBDA_PATH}\"}" > /release-metadata.json
