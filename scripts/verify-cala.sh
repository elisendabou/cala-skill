#!/usr/bin/env bash
# Verify Cala API connectivity (same credentials as MCP). No MCP client required.
# Usage: CALA_API_KEY=your_key ./scripts/verify-cala.sh
set -e
if [ -z "${CALA_API_KEY}" ]; then
  echo "Usage: CALA_API_KEY=your_key $0"
  echo "Get a key at https://console.cala.ai/api-keys"
  exit 1
fi
URL="https://api.cala.ai/v1/entities?name=Apple&limit=1"
HTTP=$(curl -s -w "%{http_code}" -o /tmp/cala-verify.json -H "X-API-KEY: ${CALA_API_KEY}" "${URL}")
if [ "$HTTP" != "200" ]; then
  echo "Cala API returned HTTP $HTTP"
  cat /tmp/cala-verify.json 2>/dev/null || true
  exit 1
fi
if ! grep -q '"entities"' /tmp/cala-verify.json 2>/dev/null; then
  echo "Unexpected response body"
  cat /tmp/cala-verify.json
  exit 1
fi
echo "OK: Cala API is reachable (entity_search for 'Apple' returned 200 with entities)."
echo "Your API key and network are fine. You can use Cala MCP in your client once configured."
