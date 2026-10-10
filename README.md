# MonsiTools MCP server

A remote [Model Context Protocol](https://modelcontextprotocol.io) server that lets AI assistants run real business, finance and SaaS calculators instead of doing the arithmetic themselves.

Language models are unreliable at arithmetic. With this server connected, the assistant finds the right calculator, reads its formula and inputs, and runs it. It gets back the same number the calculator page on [monsitools.com](https://monsitools.com) shows for the same inputs.

- **Endpoint:** `https://monsitools.com/mcp`
- **Transport:** Streamable HTTP, JSON replies, stateless (no sessions, no event stream)
- **Docs:** https://monsitools.com/developers#mcp
- **Calculator list with formulas:** https://monsitools.com/api-tools.json
- **Official MCP Registry:** `com.monsitools/calculators`

This repository holds documentation and client configs. The server itself runs on monsitools.com; there is nothing to install or host.

## Tools

All three tools are read-only.

| Tool | What it does | Key needed |
|---|---|---|
| `search_calculators` | Finds calculators by keyword, like "runway", "break even" or "roas". Returns each match's slug, name, category and input names. | No |
| `describe_calculator` | Returns one calculator's formula, inputs and page URL. | No |
| `calculate` | Runs a calculator on numeric inputs and returns the result. Every declared input is required, so a missing one is an error, never a silent zero. | No for 10 a day per IP address; a Premium key for more |

## Limits

- Without a key, `calculate` runs 10 successful calculations a day per IP address. Failed calculations don't count. The allowance resets at midnight UTC. After that, `calculate` replies with a short message linking to [Premium](https://monsitools.com/pricing).
- With a MonsiTools Premium API key there is no daily limit, and the rate limit is 60 requests a minute.
- Calculation inputs are not stored. Without a key, the only thing kept is a daily count under a one-way hash of the date and IP address. With a key, your account keeps a usage record (calls, errors, which calculators), shown on your dashboard.

## Connect it

No key is needed to start. Add the URL, and add the `Authorization` header only if you have a Premium key (`mt_live_...`, created on your [dashboard](https://monsitools.com/dashboard) under API access).

**Claude (claude.ai and the desktop app):** Settings, Connectors, Add custom connector, then paste `https://monsitools.com/mcp`. Choose "No sign-in".

**Claude Code**

```bash
claude mcp add --transport http monsitools https://monsitools.com/mcp
# with a Premium key:
claude mcp add --transport http monsitools https://monsitools.com/mcp \
  --header "Authorization: Bearer mt_live_YOUR_KEY"
```

**Cursor** (`~/.cursor/mcp.json`): see [`configs/cursor.json`](configs/cursor.json)

**VS Code** (`.vscode/mcp.json`): see [`configs/vscode.json`](configs/vscode.json)

**Windsurf** (`~/.codeium/windsurf/mcp_config.json`): see [`configs/windsurf.json`](configs/windsurf.json)

**Cline**: see [`llms-install.md`](llms-install.md), which Cline can follow on its own.

Clients that can't send custom headers can still connect with just the URL and use the keyless allowance.

## Try it without a client

The server speaks plain JSON-RPC over POST, so curl works:

```bash
curl -s https://monsitools.com/mcp \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call",
       "params":{"name":"search_calculators","arguments":{"query":"runway"}}}'
```

More in [`examples/`](examples).

## Example prompts

- "What's my SaaS runway with $180,000 in the bank, $12,000 MRR and $30,000 monthly burn?"
- "Find a break-even calculator and work out the units I need with $40,000 fixed costs, an $18 variable cost and a $45 price."
- "What's the monthly payment on a $25,000 loan at 7.5% over 5 years?"

## JSON API

The same calculators are available as a plain JSON API at `POST https://monsitools.com/api/calculate` for Premium accounts. The contract is in [`/openapi.json`](https://monsitools.com/openapi.json).

## Support

Questions or a calculator that gives a wrong answer: use the [contact form](https://monsitools.com/about#contact) or open an issue in this repository.

## Privacy

See https://monsitools.com/privacy.
