# Cala MCP (OpenClaw / Cursor skill)

Connect [OpenClaw](https://openclaw.ai) and [Cursor](https://cursor.com) to [Cala's MCP](https://docs.cala.ai/mcp) so the agent can use Cala's verified knowledge layer: natural-language search, structured queries, and entity lookup.

## What this skill does

- **When to use**: When the user wants to connect to Cala's MCP, set up Cala in Cursor or OpenClaw, or use Cala for knowledge search.
- **Instructions**: How to get a Cala API key and add the MCP config to `~/.cursor/mcp.json` (and other clients).
- **After connection**: The agent gains Cala tools (knowledge search, knowledge query, entity search, get entity, entity introspection).

**Compatibility:** This skill ships both `SKILL.md` (for Cursor and OpenClaw workspace) and `skill.yaml` (for ClawHub and OpenClaw CLI installs) so it works with the widest range of setups.

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

The repo includes both **SKILL.md** (Cursor and OpenClaw workspace) and **skill.yaml** (ClawHub and OpenClaw CLI) so it works across clients.

- **ClawHub**: Install via [ClawHub](https://clawhub.ai) (search for "Cala MCP") when published.
- **Cursor**: Copy the skill folder into `~/.cursor/skills/cala-mcp/` (include `SKILL.md`). Restart Cursor.
- **OpenClaw (workspace)**: Clone or copy into your OpenClaw workspace skills directory, e.g. `~/.openclaw/workspace/skills/cala-mcp/` or `./skills/cala-mcp/` in the workspace. Include `SKILL.md`. Refresh skills or restart the gateway.
- **OpenClaw (user skills)**: `git clone https://github.com/elisendabou/cala-skill.git ~/.openclaw/skills/cala-mcp` then refresh/restart.

No need to publish to ClawHub to use locally: install by placing the skill in the right directory for your client (see above).


## Links

- [Cala MCP docs](https://docs.cala.ai/mcp)
- [Cala](https://cala.ai) · [API keys](https://console.cala.ai/api-keys)
- [Model Context Protocol](https://modelcontextprotocol.io)

## License

MIT
