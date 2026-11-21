# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Docs and client configs for the MonsiTools MCP server. There is no source code, build, lint or test setup, and nothing to install or host. The server runs on monsitools.com (`https://monsitools.com/mcp`, Streamable HTTP, JSON replies, stateless) and is built in the `Monsibd/MonsiTools` repo, not here.

Do not add a package manifest, build step or dependencies. `llms-install.md` tells agents to clone, build and run nothing, and that must stay true.

## Layout

- `README.md`: the public doc. Tools, limits, connect steps per client, curl example, privacy.
- `llms-install.md`: steps written for an AI agent (Cline) installing the server for a user.
- `configs/`: ready-to-copy client configs (`cursor.json`, `cursor-with-key.json`, `vscode.json`, `windsurf.json`). The README links to them by path.
- `examples/curl.sh`: raw JSON-RPC calls against the live endpoint.

## Facts that must agree across files

When one of these changes, update every place it appears (`README.md`, `llms-install.md`, `examples/curl.sh`, `configs/`):

- Tools: `search_calculators`, `describe_calculator`, `calculate`. All read-only. `calculate` needs every declared input, so a missing one is an error, never a silent zero.
- Limits: 10 successful calculations a day per IP without a key (resets midnight UTC, failures do not count). A Premium key (`mt_live_...`, sent as `Authorization: Bearer`) removes the daily limit and allows 60 requests a minute.
- The verification call is `search_calculators` with `{"query": "runway"}`, which must return `saas-runway-calculator`. The curl example's `calculate` run (180000 cash, 12000 revenue, 30000 burn) is documented as 10 months.
- Real keys never appear anywhere. Configs use the placeholder `mt_live_YOUR_KEY`.

## Behavior of the live server

Changes to what the server does happen in `Monsibd/MonsiTools`, not here. This repo only describes it. Do not document a tool, limit or behavior that the live endpoint does not have. Check with `examples/curl.sh` if unsure.

## Writing

Follow the family rules from the other Monsi repos: no em dashes or en dashes anywhere, plain words, concrete facts, no invented numbers or claims. Do not describe MonsiTools as "free". The accurate wording is the keyless allowance of 10 a day.
