---
name: cala-mcp
description: Use Cala's verified knowledge layer: natural-language search, structured queries, entity lookup. Install from ClawHub, set your Cala API key in skill config, then ask your agent anything—the skill calls Cala for you. No MCP required. Optionally use Cala via MCP in Cursor/other clients.
---

# Cala skill — use Cala from OpenClaw or Cursor

**Fully fleshed skill:** When installed from ClawHub (or from this repo) with your Cala API key set in skill config, the agent can **call Cala directly** via `scripts/cala.sh`. No MCP or MCPorter needed. You ask, the skill runs the script, you get answers.

- **When to use:** User wants to search Cala, query Cala, find an entity (company, person), or get verified knowledge. The agent runs `scripts/cala.sh` with subcommand `search`, `entity`, or `query` and the user's question.
- **Config:** Set `cala_api_key` in skill config (or `CALA_API_KEY` in the environment). Get a key at [console.cala.ai/api-keys](https://console.cala.ai/api-keys).
- **Verify:** Run `CALA_API_KEY=your_key ./scripts/verify-cala.sh` to confirm API and key work.

Below: optional **MCP setup** for Cursor/Claude/VS Code/OpenClaw+MCPorter if you prefer using Cala via MCP instead of the script.

## Setup (Cursor)

1. **Get an API key**  
   Create a key at [console.cala.ai/api-keys](https://console.cala.ai/api-keys) (free account).

2. **Add MCP config**  
   Edit `~/.cursor/mcp.json`. If the file or `mcpServers` doesn't exist, create it. Add:

```json
{
  "mcpServers": {
    "Cala": {
      "url": "https://api.cala.ai/mcp/",
      "headers": {
        "X-API-KEY": "YOUR_CALA_API_KEY"
      }
    }
  }
}
```

Replace `YOUR_CALA_API_KEY` with the key from the console. Restart Cursor so the MCP server loads.

## Setup (other clients)

- **Claude Desktop**: Settings → Developer → Edit Config. Use the same `url` and pass the API key via `npx mcp-remote` with `--header "X-API-KEY: YOUR_CALA_API_KEY"`. See [Cala MCP docs](https://docs.cala.ai/mcp).
- **VS Code**: Add to `.vscode/mcp.json` under `servers.Cala` with `type: "http"`, `url: "https://api.cala.ai/mcp/"`, and `headers["X-API-KEY"]`.
- **OpenClaw (with MCPorter)**: OpenClaw needs the **MCPorter** skill to call MCP servers. Install MCPorter if needed (`npm install -g mcporter`). Add Cala to MCPorter config: `~/.mcporter/mcporter.json` or `./config/mcporter.json` in the workspace. Use the same shape as Cursor (e.g. under `mcpServers` or `servers`: `"Cala"` with `url: "https://api.cala.ai/mcp/"` and `headers: { "X-API-KEY": "YOUR_CALA_API_KEY" }`). MCPorter can also merge from Cursor’s `~/.cursor/mcp.json`, so if Cala is already there it may be picked up. Ensure the MCPorter skill is active in OpenClaw so the agent can call Cala’s tools.
- **OpenClaw (other)**: If your setup uses a different MCP bridge, add Cala to that config (same URL and `X-API-KEY` header).

## After connection

Once Cala MCP is connected, the agent gets tools such as:

| Goal | Tool / use |
|------|------------|
| Natural-language question with sources | Knowledge search |
| Structured filters (e.g. `startups.location=Spain.funding>10M`) | Knowledge query |
| Find entity by name | Entity search |
| Full profile for a known entity ID | Get entity |
| Discover fields for an entity UUID | Entity introspection |

Direct the user to [docs.cala.ai/mcp](https://docs.cala.ai/mcp) for full tool list and [docs.cala.ai](https://docs.cala.ai) for API and concepts.

## Verify setup (no MCP client needed)

Run the included script with your API key to confirm Cala is reachable and the key works:

`CALA_API_KEY=your_key ./scripts/verify-cala.sh`

It calls Cala's REST API (entity search for "Apple"). Success means the same credentials will work for the skill script and for MCP if you use it.

## Optional: MCP setup (Cursor, Claude, VS Code, OpenClaw+MCPorter)

If you prefer to use Cala via MCP instead of the built-in script, follow the steps below.

## Troubleshooting: timeouts (e.g. knowledge_search after 120s)

**knowledge_search** can be slow (natural-language search plus sources and explainability). A 120s timeout usually means the client (e.g. MCPorter) or bridge is cutting the call off before Cala responds.

- **Increase the client timeout.** If using MCPorter, set a higher timeout (e.g. `timeoutMs` in config or `--mcporter-timeout-ms`). Try 180000 (3 min) or 300000 (5 min) for knowledge_search. Where this is set depends on your OpenClaw/MCPorter setup (e.g. `mcporter.json`, env, or skill args).
- **Verify connectivity with a fast tool first.** Call **entity_search** (e.g. name "Apple") or **knowledge_query** with a simple filter. If those succeed, Cala MCP is reachable and the issue is likely knowledge_search exceeding the current timeout.
- **Check from the same machine.** From the VPS: `curl -s -o /dev/null -w "%{http_code}" -H "X-API-KEY: YOUR_KEY" "https://api.cala.ai/mcp/"`. 200/401 means reachable; timeouts point to network/firewall.
- **Confirm API key.** Wrong or expired key can cause hangs. Re-check [console.cala.ai/api-keys](https://console.cala.ai/api-keys).
- **Prefer knowledge_query when it fits.** For list-style questions (e.g. startups in X with funding > Y), **knowledge_query** is often faster and more token-efficient; use it to reduce timeout risk.
