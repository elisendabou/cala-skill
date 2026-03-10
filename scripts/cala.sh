#!/usr/bin/env bash
# Cala API client for the skill. No MCP required.
# Usage: CALA_API_KEY=key ./scripts/cala.sh search "What are the biggest AI startups in Europe?"
#        CALA_API_KEY=key ./scripts/cala.sh entity "Apple"
#        CALA_API_KEY=key ./scripts/cala.sh query "startups.location=Spain.funding>10M"
set -e
BASE_URL="https://api.cala.ai/v1"
if [ -z "${CALA_API_KEY}" ]; then
  echo "Error: CALA_API_KEY is not set. Set it in skill config or env."
  echo "Get a key at https://console.cala.ai/api-keys"
  exit 1
fi
usage() {
  echo "Usage: CALA_API_KEY=key $0 search \"<natural language question>\""
  echo "       CALA_API_KEY=key $0 entity \"<entity name>\""
  echo "       CALA_API_KEY=key $0 query \"<structured query e.g. startups.location=Spain.funding>10M>\""
  exit 1
}
[ $# -lt 2 ] && usage
CMD="$1"
shift
INPUT="$*"
# Build JSON input field (escape backslash and double quote)
json_input() {
  local s="$1"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  printf '{"input":"%s"}' "$s"
}
case "$CMD" in
  search)
    BODY_JSON=$(json_input "$INPUT")
    RESP=$(curl -s -w "\n%{http_code}" -X POST "${BASE_URL}/knowledge/search" \
      -H "X-API-KEY: ${CALA_API_KEY}" \
      -H "Content-Type: application/json" \
      -d "$BODY_JSON")
    ;;
  entity)
    # Simple URL encode: leave alphanumeric and -_. as-is, encode space as %20
    ENCODED=$(echo "$INPUT" | sed 's/ /%20/g; s/"/%22/g; s/\[/%5B/g; s/\]/%5D/g')
    RESP=$(curl -s -w "\n%{http_code}" -X GET "${BASE_URL}/entities?name=${ENCODED}&limit=10" \
      -H "X-API-KEY: ${CALA_API_KEY}")
    ;;
  query)
    BODY_JSON=$(json_input "$INPUT")
    RESP=$(curl -s -w "\n%{http_code}" -X POST "${BASE_URL}/knowledge/query" \
      -H "X-API-KEY: ${CALA_API_KEY}" \
      -H "Content-Type: application/json" \
      -d "$BODY_JSON")
    ;;
  *)
    usage
    ;;
esac
HTTP_CODE=$(echo "$RESP" | tail -n1)
OUT=$(echo "$RESP" | sed '$d')
if [ "$HTTP_CODE" != "200" ]; then
  echo "Cala API returned HTTP $HTTP_CODE" >&2
  echo "$OUT" >&2
  exit 1
fi
echo "$OUT"
