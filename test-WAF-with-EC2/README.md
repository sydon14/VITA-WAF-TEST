# VITA WAF Test Infrastructure

This setup contains the Terraform configuration used to simulate **AWS WAF (Web Application Firewall)** deployment and testing across **multiple agency ALBs** (Application Load Balancers).

## Purpose

To create a simple, reusable mock infrastructure for validating AWS WAF rules against application endpoints. This setup is meant to support CI/CD-based WAF deployments across agencies like **DMV**, **DOT**, and **TAX**, using a shared EC2 instance.

---

## Infrastructure Components

| Resource           | Purpose                                                                 |
|--------------------|-------------------------------------------------------------------------|
| `VPC`              | Private network to host all test components                             |
| `Subnets`          | Two subnets (`us-east-1a`, `us-east-1b`) for HA and ALB placement       |
| `Internet Gateway` | Enables outbound internet access                                        |
| `Route Table`      | Routes external traffic to subnets via Internet Gateway                 |
| `Security Group`   | Allows inbound HTTP traffic on port 80                                  |
| `EC2 Instance`     | Amazon Linux 2 instance running Apache (used to simulate an app)        |
| `ALBs`             | One ALB per agency (DMV, DOT, TAX) to test individual WAF deployments   |
| `Target Groups`    | Each ALB points to the shared EC2 instance                              |
| `Listeners`        | Route HTTP traffic to their respective target groups                    |

---

## How It Works

- A single EC2 instance hosts a simple HTTP web page.
- Each ALB is configured to forward traffic to the EC2 instance.
- Each agency’s WAF deployment references its ALB ARN.
- WAF rules are deployed and validated per agency via GitHub Actions.

---

## Apache Setup on EC2 (User Data)

```bash
#!/bin/bash
sudo yum install -y httpd
echo "WAF Demo Page" > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd