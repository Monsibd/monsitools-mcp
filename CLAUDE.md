# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Documentation and client configs for the MonsiTools MCP server. There is no server code here and nothing to build, install or test.

- `README.md`: what the server does, its three tools, limits, and how to connect each client.
- `llms-install.md`: step-by-step setup written for an AI coding agent installing the server for a user.
- `configs/`: ready-to-paste client configs (`cursor.json`, `cursor-with-key.json`, `vscode.json`, `windsurf.json`).
- `examples/curl.sh`: a runnable call against the live endpoint.

## Where the server lives

The server is the `/mcp` route of the MonsiTools Cloudflare Worker, in the `Monsibd/MonsiTools` repo, file `src/worker.js` (`handleMcp`). Tool names, descriptions and input schemas, the `serverInfo` and `instructions` text, supported protocol versions and the keyless daily cap (`MCP_KEYLESS_DAILY_CAP`) are all defined there. Its tests are `tests/js/worker-mcp.test.js` and `tests/js/worker-mcp-keyless.test.js` in that repo.

Any change to how the server behaves is made in MonsiTools, not here. Then update this repo so the docs match: the tool table and limits in `README.md`, the steps in `llms-install.md`, and the configs if the endpoint or headers change.

## Facts the docs must keep in step with the code

- Endpoint `https://monsitools.com/mcp`, Streamable HTTP, JSON replies, stateless.
- Three read-only tools: `search_calculators`, `describe_calculator`, `calculate`.
- `calculate` without a key: 10 successful calculations a day per IP address, reset at midnight UTC. A Premium key (`Authorization: Bearer mt_live_...`) removes the daily limit; the rate limit is then 60 requests a minute.
- Registry name `com.monsitools/calculators`.

Check a claim against `src/worker.js` before changing it in the docs. To test the live server, run `examples/curl.sh`.

## Writing

Follow the MonsiTools writing rules (`docs/writing-style.md` in that repo): plain words, no em or en dashes, never describe MonsiTools as "free" except when stating the keyless allowance with its number.
