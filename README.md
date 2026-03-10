# Cala skill for OpenClaw & Cursor

Use [Cala](https://cala.ai)'s verified knowledge layer from your agent: natural-language search, structured queries, entity lookup. **Download from ClawHub, add your API key, then ask anything—the skill calls Cala for you.** No MCP required.

## Install and use (ClawHub — like Tavily)

1. **Install the skill**
   ```bash
   clawhub login
   clawhub install cala-mcp
   ```
   Or from git: `openclaw skills install https://github.com/elisendabou/cala-skill.git` or clone into your `skills/` directory.

2. **Set your Cala API key** in the skill config (ClawHub or OpenClaw will prompt for it, or set `CALA_API_KEY` in the environment). Get a key at [console.cala.ai/api-keys](https://console.cala.ai/api-keys).

3. **Ask your agent** — e.g. "Search Cala for the biggest AI startups in Europe" or "Find entity Apple in Cala". The skill runs `scripts/cala.sh` and returns Cala's answer. No MCP or MCPorter needed.

**Verify:** From the skill directory run `CALA_API_KEY=your_key ./scripts/verify-cala.sh` to confirm the API key works.

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

## Install (same as Tavily and other ClawHub skills)

Once this skill is published on ClawHub, anyone can install it the same way as Tavily:

```bash
clawhub login
clawhub install cala-mcp
```

(Use the slug shown on ClawHub after publish; `cala-mcp` is the intended slug.)

**Without ClawHub** (install from this repo):

```bash
# OpenClaw CLI (if your build supports it)
openclaw skills install https://github.com/elisendabou/cala-skill.git

# Or clone into your skills directory
git clone https://github.com/elisendabou/cala-skill.git ~/.openclaw/skills/cala-mcp
# or for workspace: git clone https://github.com/elisendabou/cala-skill.git ./skills/cala-mcp
```

Then set your Cala API key in skill config (or use MCP setup below for Cursor).

**Cursor (MCP path):** To use Cala via MCP in Cursor instead of the script, copy the skill into `~/.cursor/skills/cala-mcp/` and add Cala to `~/.cursor/mcp.json` (see [Quick setup (Cursor)](#quick-setup-cursor)).

**Publishing to ClawHub (for skill authors):** From this repo run `clawhub publish` (or use [clawhub.ai](https://clawhub.ai)) so others can `clawhub install cala-mcp`.

**Verify (no MCP required):** From the skill directory, run `CALA_API_KEY=your_key ./scripts/verify-cala.sh`. It performs a real Cala API call (entity search for "Apple") and prints OK on success.

### Install on OpenClaw VPS (without ClawHub)

1. **SSH into your VPS** and go to the OpenClaw app/workspace directory (e.g. where OpenClaw is installed or where your workspace lives).

2. **Clone the skill** into OpenClaw’s skills directory. Use whichever your setup uses:
   - **User skills** (all workspaces):  
     `git clone https://github.com/elisendabou/cala-skill.git ~/.openclaw/skills/cala-mcp`
   - **Workspace skills** (this project only):  
     `cd /path/to/openclaw-workspace && git clone https://github.com/elisendabou/cala-skill.git ./skills/cala-mcp`

3. **If you use MCPorter** (so OpenClaw can call MCP servers), add Cala to MCPorter’s config. Edit `~/.mcporter/mcporter.json` or `./config/mcporter.json` in the workspace and add Cala under your servers (same shape as Cursor):
   ```json
   "Cala": {
     "url": "https://api.cala.ai/mcp/",
     "headers": { "X-API-KEY": "YOUR_CALA_API_KEY" }
   }
   ```
   Get an API key at [console.cala.ai/api-keys](https://console.cala.ai/api-keys). If Cala is already in `~/.cursor/mcp.json`, MCPorter may pick it up from there.

4. **Refresh skills or restart OpenClaw** (e.g. restart the gateway / app) so it loads the new skill. If you use MCPorter, ensure that skill is enabled.

5. In the OpenClaw UI or CLI, ask the agent to connect to Cala or search Cala; the skill will guide it (and users) through the config if needed.

**If knowledge_search times out (e.g. after 120s):** Cala’s natural-language search can be slow. Increase MCPorter’s timeout (`timeoutMs` or `--mcporter-timeout-ms`, e.g. 180000–300000 ms). Test with a fast tool first (e.g. `entity_search` for "Apple") to confirm the connection. Prefer `knowledge_query` for list-style questions when possible. See **Troubleshooting** in [SKILL.md](SKILL.md).

- [Cala MCP docs](https://docs.cala.ai/mcp)
- [Cala](https://cala.ai) · [API keys](https://console.cala.ai/api-keys)
- [Model Context Protocol](https://modelcontextprotocol.io)

## License

MIT
