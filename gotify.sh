#!/bin/sh

TRIMMED_URL=$(echo "${PLUGIN_GOTIFY_URL}" | sed 's:/*$::')

PRIORITY="${PLUGIN_PRIORITY:-0}"
if [[ ! "${priority}" =~ ^[1-9][0-9]*$ ]]; then
    PRIORITY=5
fi
PRIORITY=$((PRIORITY))

DEFAULT_TITLE="${DRONE_REPO_NAME}:${DRONE_BUILD_NUMBER} ${DRONE_BUILD_STATUS}"
DEFAULT_MESSAGE="Build ${DRONE_BUILD_NUMBER} of ${DRONE_REPO}: (${DRONE_COMMIT_MESSAGE}): ${DRONE_BUILD_LINK}"

MESSAGE="${PLUGIN_MESSAGE:-${DEFAULT_MESSAGE}}"
ESCAPED_MESSAGE=$(echo "${MESSAGE}" | sed ':a;N;$!ba;s/\n/\\n/g')
ESCAPED_TITLE=$(echo "${PLUGIN_TITLE:-${DEFAULT_TITLE}}" | sed ':a;N;$!ba;s/\n/\\n/g')

curl \
    -q -s \
    -H "Content-Type: application/json" \
    -H "X-Gotify-Key: ${PLUGIN_TOKEN}" \
    -d '{
        "title": "'"${ESCAPED_TITLE}"'",
        "message": "'"${ESCAPED_MESSAGE}"'",
        "priority": '${PRIORITY}'
    }' \
    "${TRIMMED_URL}/message"
