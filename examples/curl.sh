#!/bin/sh
# List the tools
curl -s https://monsitools.com/mcp -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'

# Find a calculator
curl -s https://monsitools.com/mcp -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"search_calculators","arguments":{"query":"runway"}}}'

# See its inputs
curl -s https://monsitools.com/mcp -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"describe_calculator","arguments":{"slug":"saas-runway-calculator"}}}'

# Run it (expected result: 10 months)
curl -s https://monsitools.com/mcp -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":4,"method":"tools/call","params":{"name":"calculate","arguments":{"slug":"saas-runway-calculator","inputs":{"cash_balance":180000,"monthly_revenue":12000,"monthly_burn_rate":30000}}}}'
