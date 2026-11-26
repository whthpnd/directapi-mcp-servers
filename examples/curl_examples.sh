#!/usr/bin/env bash
set -euo pipefail

: "${APIFY_TOKEN:?Set APIFY_TOKEN environment variable first}"

# 1. B2B Company + EU Impressum + VIES VAT + OFAC + Signup Fraud Risk
curl -sS -H "Authorization: Bearer $APIFY_TOKEN" \
  "https://whthpnd--b2b-company-kyb-risk-api.apify.actor/v1/full?target=sipgate.de" | jq .

# 2. Fast Signup Fraud Risk (<250ms)
curl -sS -H "Authorization: Bearer $APIFY_TOKEN" \
  "https://whthpnd--b2b-company-kyb-risk-api.apify.actor/v1/risk?target=user@mailinator.com" | jq .

# 3. Website SEO, /llms.txt (GEO) & SSL/Security Headers
curl -sS -H "Authorization: Bearer $APIFY_TOKEN" \
  "https://whthpnd--seo-geo-security-audit-api.apify.actor/v1/audit?domain=stripe.com" | jq .

# 4. Domain, Brand & Handle Availability (.com/.io/.ai + GitHub/npm/App Store)
curl -sS -H "Authorization: Bearer $APIFY_TOKEN" \
  "https://whthpnd--domain-brand-availability-api.apify.actor/v1/check?name=luminaflux&tlds=com,io,ai,dev" | jq .

# 5. iOS App Store Reviews & Developer Contact Leads
curl -sS -H "Authorization: Bearer $APIFY_TOKEN" \
  "https://whthpnd--ios-app-store-leads-reviews-api.apify.actor/v1/app?id=1232780281&maxReviews=5" | jq .

# 6. SEC XBRL Financials & Form 4 Insider Trades
curl -sS -H "Authorization: Bearer $APIFY_TOKEN" \
  "https://whthpnd--sec-financials-insider-trading-api.apify.actor/v1/full?ticker=NVDA" | jq .

# 7. MCP Streamable HTTP JSON-RPC tools/list
curl -sS -X POST \
  -H "Authorization: Bearer $APIFY_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}' \
  "https://whthpnd--b2b-company-kyb-risk-api.apify.actor/mcp" | jq .
