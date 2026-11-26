#!/usr/bin/env python3
"""Zero-dependency quickstart for DirectAPI Labs Standby REST APIs and /mcp servers."""
import json
import os
import sys
import urllib.request


def get_json(url: str, token: str, payload: dict | None = None) -> dict:
    headers = {"Authorization": f"Bearer {token}", "Accept": "application/json"}
    data = None
    if payload is not None:
        headers["Content-Type"] = "application/json"
        data = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(url, data=data, headers=headers)
    with urllib.request.urlopen(req, timeout=45) as resp:
        return json.loads(resp.read().decode("utf-8"))


def main() -> None:
    token = os.environ.get("APIFY_TOKEN", "").strip()
    if not token:
        print("Set APIFY_TOKEN environment variable first.", file=sys.stderr)
        sys.exit(1)

    print("1. Standby REST call: B2B Company + EU VAT + Fraud Risk (sipgate.de)")
    b2b = get_json("https://whthpnd--b2b-company-kyb-risk-api.apify.actor/v1/full?target=sipgate.de", token)
    print(json.dumps({
        "companyName": b2b.get("companyName"),
        "legalName": b2b.get("legalName"),
        "vatNumber": b2b.get("vatNumber"),
        "vatValid": b2b.get("vatValid"),
        "riskScore": b2b.get("riskScore"),
        "riskVerdict": b2b.get("riskVerdict"),
    }, indent=2))

    print("\n2. MCP Streamable HTTP tools/list + tools/call (b2b-company-kyb-risk)")
    mcp_url = "https://whthpnd--b2b-company-kyb-risk-api.apify.actor/mcp"
    listed = get_json(mcp_url, token, {"jsonrpc": "2.0", "id": 1, "method": "tools/list"})
    print("Available MCP tools:", [t["name"] for t in listed["result"]["tools"]])

    called = get_json(
        mcp_url,
        token,
        {
            "jsonrpc": "2.0",
            "id": 2,
            "method": "tools/call",
            "params": {"name": "assess_email_domain_risk", "arguments": {"target": "test@mailinator.com"}},
        },
    )
    print("MCP tool result:", json.dumps(called["result"].get("structuredContent"), indent=2))


if __name__ == "__main__":
    main()
