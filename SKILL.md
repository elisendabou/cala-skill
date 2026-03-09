---
name: cala-mcp
description: Connects OpenClaw/Cursor to Cala's MCP for verified knowledge search. Use when the user wants to connect to Cala MCP, set up Cala in Cursor or OpenClaw, get an API key, or use Cala's knowledge layer, entity search, or structured queries.
---

# Connect to Cala's MCP

Guides setup of Cala's Model Context Protocol (MCP) so the agent can use Cala's knowledge layer: verified, structured knowledge and entity search. Official docs: [docs.cala.ai/mcp](https://docs.cala.ai/mcp).

## When to use

- User wants to "connect to Cala's MCP", "use Cala", or "set up Cala in Cursor/OpenClaw".
- User asks how to get Cala knowledge search, entity lookup, or structured queries in their agent.

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
- **OpenClaw**: Use the same JSON shape in the MCP config location your OpenClaw setup expects (often similar to Cursor’s `mcp.json` or project-level MCP config).

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
