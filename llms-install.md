# Installing the MonsiTools MCP server

These steps are written for an AI coding agent (such as Cline) setting up this server for a user.

1. This is a remote server. Do not clone, build or run anything. There is no package to install.
2. Add a server named `monsitools` to the client's MCP settings with:
   - transport: Streamable HTTP
   - URL: `https://monsitools.com/mcp`
3. No API key is required. Leave headers empty unless the user provides a MonsiTools Premium key, which starts with `mt_live_`. If they do, add the header `Authorization: Bearer <their key>`. Never invent a key.
4. Verify the connection by calling the `search_calculators` tool with `{"query": "runway"}`. A working server returns a list that includes `saas-runway-calculator`.
5. Tell the user:
   - `search_calculators` and `describe_calculator` work without limits.
   - `calculate` runs 10 calculations a day per IP address without a key; a Premium key removes the daily limit.
   - To run a calculation: find it with `search_calculators`, check its inputs with `describe_calculator`, then call `calculate` with every input as a number.
