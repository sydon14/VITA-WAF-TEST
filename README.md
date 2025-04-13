# VITA AWS WAF Terraform Deployment Test

This project provides a reusable Terraform module and automation structure to deploy AWS WAF WebACLs for multiple agencies (e.g., DMV, Tax, DOT) under the Virginia Information Technology Agency (VITA).

## 📁 Folder Structure

```
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
```

## ⚙️ How It Works

- Each agency has a Terraform config that references a shared WAF module.
- The module deploys a WebACL using AWS Managed Rules to block common attacks.
- GitHub Actions automates the deployment when changes are pushed.

## Included AWS Managed Rules

This module uses AWS Managed Rules to protect applications against common threats:

- `AWSManagedRulesSQLiRuleSet` - Blocks SQL Injection attempts
- `AWSManagedRulesXSSRuleSet` - Blocks Cross-site scripting (XSS)
- `AWSManagedRulesCommonRuleSet` - Protects against common threats like bad bots and request floods
- `AWSManagedRulesKnownBadInputsRuleSet` - Blocks known malicious patterns

## Deployment Steps

1. **Customize `main.tf`** under each agency folder with the agency's ALB ARN.
2. **Commit changes** to the GitHub repository.
3. **GitHub Actions** will automatically initialize and apply the WAF configuration.

## Prerequisites

- Terraform installed locally if testing manually
- AWS credentials with permissions to deploy WAF and manage ALBs
- GitHub repository connected with GitHub Actions enabled