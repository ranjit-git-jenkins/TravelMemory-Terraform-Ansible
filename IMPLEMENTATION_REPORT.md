# Implementation report (design and execution checklist)

## Scope
Terraform declares VPC, IGW, NAT gateway, routes, public/private EC2, IAM instance profile, security groups, and web public IP output. Ansible declares MongoDB, Node.js, frontend build, Nginx, systemd and SSH hardening.

## Required adaptations before deployment
1. Verify the TravelMemory repository's **actual** frontend/backend folder names, npm scripts, Node.js version, API base URL and MongoDB environment variable. This package assumes `frontend`, `backend`, `npm start`, `MONGO_URI` and `build/`; these are **not yet verified**.
2. MongoDB playbook targets Ubuntu 22.04 (Jammy) with MongoDB 7.0. Verify supported versions and apt repository reachability.
3. Add a dedicated MongoDB administrator account and test authenticated access before enabling authorization in a production environment. Current role creates an application readWrite user; a separate admin account is strongly recommended.
4. Move database credentials to Ansible Vault, verify host SSH key fingerprints, and test ProxyJump.
5. Install a suitable supported Node.js version; Ubuntu's default `nodejs` may not match app requirements.
6. Use TLS/HTTPS and a DNS name for real deployments. Avoid exposing backend port directly.
7. Confirm IAM permissions are sufficient; no broad managed policy is attached by default.

## Execution record
**Not executed**: No AWS resources were provisioned, no Ansible deployment was run, and no working-application screenshots are supplied. Replace this note with truthful command outputs/screenshots only after performing the steps.

## Validation checklist
- `terraform fmt -check && terraform validate && terraform plan` (after init and credentials)
- `ansible-playbook --syntax-check site.yml` (after dependencies/inventory)
- `ansible-playbook -i inventory.ini site.yml --check --diff` (review carefully)
- Web: `curl -I http://WEB_PUBLIC_IP/`
- Backend health: application-specific endpoint, if available
- DB: authenticated MongoDB connection from web EC2
- SSH: root and password authentication denied
- Screenshot of working UI, Terraform outputs and Ansible play recap

## Challenges and solutions
- Private EC2 SSH: use ProxyJump through public EC2.
- DB not publicly reachable: security-group-to-security-group MongoDB rule.
- Frontend API routing: Nginx `/api/` reverse proxy; adapt if app uses another path.
- Sensitive data: keep real passwords in Ansible Vault, not Git.
