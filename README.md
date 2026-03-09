# Cala MCP (OpenClaw / Cursor skill)

Connect [OpenClaw](https://openclaw.ai) and [Cursor](https://cursor.com) to [Cala's MCP](https://docs.cala.ai/mcp) so the agent can use Cala's verified knowledge layer: natural-language search, structured queries, and entity lookup.

## What this skill does

- **When to use**: When the user wants to connect to Cala's MCP, set up Cala in Cursor or OpenClaw, or use Cala for knowledge search.
- **Instructions**: How to get a Cala API key and add the MCP config to `~/.cursor/mcp.json` (and other clients).
- **After connection**: The agent gains Cala tools (knowledge search, knowledge query, entity search, get entity, entity introspection).

## Quick setup (Cursor)

1. Get an API key: [console.cala.ai/api-keys](https://console.cala.ai/api-keys)
2. Add to `~/.cursor/mcp.json`:

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

3. Restart Cursor.

Full details and other clients (Claude Desktop, VS Code) are in [SKILL.md](SKILL.md) and [docs.cala.ai/mcp](https://docs.cala.ai/mcp).

## Install

- **ClawHub**: Install via [ClawHub](https://clawhub.ai) (search for "Cala MCP").
- **Manual**: Copy the `SKILL.md` (and optional reference) into your skills directory, e.g. `~/.cursor/skills/cala-mcp/` or `.cursor/skills/cala-mcp/`.


## Links

- [Cala MCP docs](https://docs.cala.ai/mcp)
- [Cala](https://cala.ai) · [API keys](https://console.cala.ai/api-keys)
- [Model Context Protocol](https://modelcontextprotocol.io)

## License

MIT
