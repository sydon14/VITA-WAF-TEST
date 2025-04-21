# VITA AWS WAF Terraform Deployment Test

This project provides a reusable Terraform module and automation structure to deploy AWS WAF WebACLs for multiple agencies (e.g., DMV, Tax, DOT) under the Virginia Information Technology Agency (VITA).

## Folder Structure

waf-terraform-test/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── modules/
│   └── waf/
│       ├── main.tf
│       ├── variables.tf
├── agencies/
│   ├── dmv/
│   │   └── main.tf
│   ├── tax/
│   │   └── main.tf
│   └── dot/
│       └── main.tf

##  How It Works

- Each agency has a Terraform config that references a shared WAF module.
- The module deploys a WebACL with a configurable set of AWS Managed Rules and custom rules.
- GitHub Actions automates WAF deployment per environment (dev, stage, prod) based on branch changes.

##  Included AWS Managed Rules

This project supports several AWS Managed Rule Groups. Each agency can selectively enable the rule sets most relevant to their application.

###  Example Managed Rule Groups

- `AWSManagedRulesSQLiRuleSet` — Blocks SQL injection attacks
- `AWSManagedRulesCommonRuleSet` — Detects common threats like bad bots and protocol anomalies
- `AWSManagedRulesKnownBadInputsRuleSet` — Filters known malicious request patterns
- `AWSManagedRulesAdminProtectionRuleSet` — Protects admin portals from unauthorized access
- `AWSManagedRulesAmazonIpReputationList` — Filters requests from AWS-detected malicious IPs
- `AWSManagedRulesAnonymousIpList` — Blocks traffic from VPNs, proxies, and Tor networks
- `AWSManagedRulesBotControlRuleSet` — Detects and manages bot traffic

> 💡 Rule priorities and metric names are defined per agency, offering flexibility and fine-tuned protection.

##  Custom Rules (Agency Specific)

Each agency can also implement custom WAF rules:

- **IP Blocking**
  ```hcl
  blocked_ips = [
    "198.51.100.1/32",
    "203.0.113.45/32"
  ]

- **Geo Location Blocking**
    geo_match_countries = [
    "RU", # Russia
    "CN"  # China
  ]

## Deployment Steps

1. **Customize `main.tf`** under each agencies/ subfolder.
2. **Commit changes** to the appropriate GitHub branch (dev, stage, or prod).
3. **GitHub Actions** will automatically deploy the WAF configuration based on the branch.

## Prerequisites

- Terraform installed locally (for manual testing)
- AWS CLI with appropriate permissions (WAF, S3, ALB)
- GitHub repository with Actions enabled