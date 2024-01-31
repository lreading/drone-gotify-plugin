#!/bin/sh

TRIMMED_URL=$(echo "${PLUGIN_GOTIFY_URL}" | sed 's:/*$::')

PRIORITY="${PLUGIN_PRIORITY:-0}"
if [[ ! "${priority}" =~ ^[1-9][0-9]*$ ]]; then
    PRIORITY=5
fi
PRIORITY=$((priority))

curl \
    -q -s \
    -X POST \
    -H "Content-Type: application/json" \
    -H "X-Gotify-Key: ${PLUGIN_TOKEN}" \
    -d '{
        "title": "'"${PLUGIN_TITLE:-Default Title}"'",
        "message": "'"${PLUGIN_MESSAGE:-Default Message}"'",
        "priority": '${PRIORITY}'
    }' \
    "${TRIMMED_URL}/message"
