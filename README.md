# DirectAPI Labs — B2B Data APIs, Remote MCP Servers & n8n Workflows

Fast, proxy-free **Streamable HTTP Model Context Protocol (MCP) Servers**, real-time **Standby REST APIs**, **ready-to-import `n8n` workflows**, and lightweight `256 MB` Apify Actors — built for AI coding agents (Cursor, Claude Desktop, Windsurf), automation engineers, and outbound/research pipelines.

- **Apify Store Profile:** [apify.com/whthpnd](https://apify.com/whthpnd)
- **Zero Proxies Required:** Built exclusively on native APIs, DNS/RDAP, SEC EDGAR XBRL, EU VIES VAT, GLEIF LEI, and OFAC datasets.
- **Pay-Per-Event Pricing:** Ultra-low per-call pricing (`$0.002–$0.0035`) with automatic tier discounts up to Gold/Platinum/Diamond.

---

## Remote MCP Servers (Streamable HTTP)

Every server below speaks standard **MCP Streamable HTTP JSON-RPC 2.0** (`initialize`, `tools/list`, `tools/call`) at `/mcp` and authenticates with your Apify API token (`Authorization: Bearer YOUR_APIFY_TOKEN`).

| MCP Server | Remote `/mcp` Endpoint | Tools | Store Status |
|---|---|---|---|
| **B2B Company, EU VAT/KYB & Fraud Risk** | `https://whthpnd--b2b-company-kyb-risk-api.apify.actor/mcp` | `enrich_b2b_full`, `enrich_company_profile`, `assess_email_domain_risk`, `verify_kyb_vat_sanctions` | [Live on Apify](https://apify.com/whthpnd/b2b-company-kyb-risk-api) |
| **Website SEO, `llms.txt` (GEO) & Security Audit** | `https://whthpnd--seo-geo-security-audit-api.apify.actor/mcp` | `audit_website_full`, `check_ai_geo_readiness`, `audit_ssl_and_security_headers` | [Actor Page](https://apify.com/whthpnd/seo-geo-security-audit-api) |
| **Domain, Brand & Handle Availability** | `https://whthpnd--domain-brand-availability-api.apify.actor/mcp` | `check_brand_launch_availability`, `check_domains_only` | [Actor Page](https://apify.com/whthpnd/domain-brand-availability-api) |
| **Apple App Store Reviews & Developer Leads** | `https://whthpnd--ios-app-store-leads-reviews-api.apify.actor/mcp` | `search_ios_apps_and_developer_leads`, `get_ios_app_details`, `get_ios_app_reviews` | [Actor Page](https://apify.com/whthpnd/ios-app-store-leads-reviews-api) |
| **SEC Company Financials (XBRL) & Form 4 Insiders** | `https://whthpnd--sec-financials-insider-trading-api.apify.actor/mcp` | `get_sec_company_full`, `get_sec_xbrl_financials`, `get_sec_insider_trades` | [Actor Page](https://apify.com/whthpnd/sec-financials-insider-trading-api) |

---

## Cursor / Claude / Windsurf Config (`mcp.json`)

Copy [`mcp-configs/cursor-all-5.json`](./mcp-configs/cursor-all-5.json) (or pick the servers you need) and replace `YOUR_APIFY_TOKEN`:

```json
{
  "mcpServers": {
    "b2b-company-kyb-risk": {
      "url": "https://whthpnd--b2b-company-kyb-risk-api.apify.actor/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_APIFY_TOKEN"
      }
    },
    "seo-geo-security-audit": {
      "url": "https://whthpnd--seo-geo-security-audit-api.apify.actor/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_APIFY_TOKEN"
      }
    },
    "domain-brand-availability": {
      "url": "https://whthpnd--domain-brand-availability-api.apify.actor/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_APIFY_TOKEN"
      }
    },
    "ios-appstore-leads-reviews": {
      "url": "https://whthpnd--ios-app-store-leads-reviews-api.apify.actor/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_APIFY_TOKEN"
      }
    },
    "sec-financials-insiders": {
      "url": "https://whthpnd--sec-financials-insider-trading-api.apify.actor/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_APIFY_TOKEN"
      }
    }
  }
}
```

---

## Ready-to-Import n8n Workflows

Import any JSON from [`n8n-workflows/`](./n8n-workflows/) directly into **n8n** (`Workflows → Import from File`) and configure Header Auth (`Authorization: Bearer YOUR_APIFY_TOKEN`):

1. **[`b2b-lead-enrichment-eu-vat-risk.json`](./n8n-workflows/b2b-lead-enrichment-eu-vat-risk.json)** — Inbound signup/lead Webhook → Enrich company + EU Impressum + VIES VAT + OFAC + Fraud Score → Route verified `riskVerdict == "allow"` leads cleanly.
2. **[`website-seo-llms-txt-audit.json`](./n8n-workflows/website-seo-llms-txt-audit.json)** — Audit target websites for On-Page SEO, `/llms.txt`, `GPTBot`/`ClaudeBot` permissions, and TLS expiry → Flag sites below score threshold for agency outreach.
3. **[`sec-form4-insider-alerts.json`](./n8n-workflows/sec-form4-insider-alerts.json)** — Daily scheduled monitor fetching normalized `10-K`/`10-Q` XBRL financials and parsed Form 4 insider buys/sales for `NVDA`, `AAPL`, and `MSFT`.

---

## Quickstart (`Python` & `cURL`)

Run [`examples/quickstart.py`](./examples/quickstart.py) (zero external dependencies — stdlib only) or [`examples/curl_examples.sh`](./examples/curl_examples.sh):

```bash
export APIFY_TOKEN="YOUR_APIFY_TOKEN"
python3 examples/quickstart.py
```

Direct REST endpoint examples:

```bash
# Clearbit + Impressum + EU VAT + OFAC + Fraud Risk check
curl -s -H "Authorization: Bearer $APIFY_TOKEN" \
  "https://whthpnd--b2b-company-kyb-risk-api.apify.actor/v1/full?target=sipgate.de"

# Instant signup email/domain fraud risk (<250ms)
curl -s -H "Authorization: Bearer $APIFY_TOKEN" \
  "https://whthpnd--b2b-company-kyb-risk-api.apify.actor/v1/risk?target=test@mailinator.com"

# Website SEO + llms.txt AI search + SSL/Security headers
curl -s -H "Authorization: Bearer $APIFY_TOKEN" \
  "https://whthpnd--seo-geo-security-audit-api.apify.actor/v1/audit?domain=stripe.com"

# SEC XBRL 10-K/10-Q + Form 4 Insider Trades
curl -s -H "Authorization: Bearer $APIFY_TOKEN" \
  "https://whthpnd--sec-financials-insider-trading-api.apify.actor/v1/full?ticker=NVDA"
```

---

## Full DirectAPI Labs Actor Catalog (Apify Store)

| Category | Actor | Apify Store Link |
|---|---|---|
| **B2B Intelligence / KYB** | `b2b-company-kyb-risk-api` | [apify.com/whthpnd/b2b-company-kyb-risk-api](https://apify.com/whthpnd/b2b-company-kyb-risk-api) |
| **SEO / GEO / Security** | `seo-geo-security-audit-api` | [apify.com/whthpnd/seo-geo-security-audit-api](https://apify.com/whthpnd/seo-geo-security-audit-api) |
| **Brand & Domains** | `domain-brand-availability-api` | [apify.com/whthpnd/domain-brand-availability-api](https://apify.com/whthpnd/domain-brand-availability-api) |
| **Mobile & ASO Leads** | `ios-app-store-leads-reviews-api` | [apify.com/whthpnd/ios-app-store-leads-reviews-api](https://apify.com/whthpnd/ios-app-store-leads-reviews-api) |
| **Public Markets & SEC** | `sec-financials-insider-trading-api` | [apify.com/whthpnd/sec-financials-insider-trading-api](https://apify.com/whthpnd/sec-financials-insider-trading-api) |
| **US Trucking Leads** | `fmcsa-usdot-trucking-leads-scraper` | [apify.com/whthpnd/fmcsa-usdot-trucking-leads-scraper](https://apify.com/whthpnd/fmcsa-usdot-trucking-leads-scraper) |
| **US Healthcare Leads** | `npi-healthcare-doctors-leads-scraper` | [apify.com/whthpnd/npi-healthcare-doctors-leads-scraper](https://apify.com/whthpnd/npi-healthcare-doctors-leads-scraper) |
| **Gov Tenders (UK/FR)** | `uk-france-public-tenders-scraper` | [apify.com/whthpnd/uk-france-public-tenders-scraper](https://apify.com/whthpnd/uk-france-public-tenders-scraper) |
| **Gov Tenders (EU TED)** | `ted-europa-eu-tenders-scraper` | [apify.com/whthpnd/ted-europa-eu-tenders-scraper](https://apify.com/whthpnd/ted-europa-eu-tenders-scraper) |
| **Venture / Form D** | `sec-form-d-funded-startups-scraper` | [apify.com/whthpnd/sec-form-d-funded-startups-scraper](https://apify.com/whthpnd/sec-form-d-funded-startups-scraper) |
| **Community / RAG** | `discourse-forums-threads-scraper` | [apify.com/whthpnd/discourse-forums-threads-scraper](https://apify.com/whthpnd/discourse-forums-threads-scraper) |
| **Extension Leads** | `chrome-web-store-leads-scraper` | [apify.com/whthpnd/chrome-web-store-leads-scraper](https://apify.com/whthpnd/chrome-web-store-leads-scraper) |
| **Events & Organizers** | `luma-events-organizers-scraper` | [apify.com/whthpnd/luma-events-organizers-scraper](https://apify.com/whthpnd/luma-events-organizers-scraper) |
| **Remote Jobs** | `himalayas-remote-jobs-scraper` | [apify.com/whthpnd/himalayas-remote-jobs-scraper](https://apify.com/whthpnd/himalayas-remote-jobs-scraper) |
| **Newsletter Leads** | `substack-newsletters-posts-scraper` | [apify.com/whthpnd/substack-newsletters-posts-scraper](https://apify.com/whthpnd/substack-newsletters-posts-scraper) |
| **Podcast Host Emails** | `apple-podcasts-leads-scraper` | [apify.com/whthpnd/apple-podcasts-leads-scraper](https://apify.com/whthpnd/apple-podcasts-leads-scraper) |
| **Tech Career Boards** | `ats-jobs-greenhouse-lever-ashby` | [apify.com/whthpnd/ats-jobs-greenhouse-lever-ashby](https://apify.com/whthpnd/ats-jobs-greenhouse-lever-ashby) |
| **Jobs Multi-Feed** | `remote-jobs-multi-aggregator` | [apify.com/whthpnd/remote-jobs-multi-aggregator](https://apify.com/whthpnd/remote-jobs-multi-aggregator) |
| **Tech News / HN** | `hacker-news-fast-scraper` | [apify.com/whthpnd/hacker-news-fast-scraper](https://apify.com/whthpnd/hacker-news-fast-scraper) |
| **Remote Tech Jobs** | `weworkremotely-remote-jobs-scraper` | [apify.com/whthpnd/weworkremotely-remote-jobs-scraper](https://apify.com/whthpnd/weworkremotely-remote-jobs-scraper) |
| **Central EU Ads** | `bazos-classifieds-scraper` | [apify.com/whthpnd/bazos-classifieds-scraper](https://apify.com/whthpnd/bazos-classifieds-scraper) |
| **Live Music Tickets** | `dice-fm-events-scraper` | [apify.com/whthpnd/dice-fm-events-scraper](https://apify.com/whthpnd/dice-fm-events-scraper) |
| **Electronic Events** | `resident-advisor-events-scraper` | [apify.com/whthpnd/resident-advisor-events-scraper](https://apify.com/whthpnd/resident-advisor-events-scraper) |
| **Prediction Markets** | `polymarket-kalshi-prediction-markets` | [apify.com/whthpnd/polymarket-kalshi-prediction-markets](https://apify.com/whthpnd/polymarket-kalshi-prediction-markets) |

---

## License

MIT © 2026 [DirectAPI Labs](https://apify.com/whthpnd)
