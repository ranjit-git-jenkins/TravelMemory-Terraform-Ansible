# TravelMemory — Terraform and Ansible assignment

**Repository purpose:** Infrastructure-as-code and configuration-management templates for the Hero Vired MERN assignment. This is a **configuration-only deliverable** until deployed and verified in AWS.

## Requirements
- Terraform >=1.6, AWS account with permission to create EC2/VPC/NAT/IAM, existing EC2 SSH key pair.
- Ansible on an operator machine, SSH client, Python, collections from `ansible/requirements.yml`.
- Source app: https://github.com/UnpredictablePrashant/TravelMemory

## Provision AWS infrastructure
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# EDIT admin_cidr and key_name; do not commit secrets
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
terraform output
```
**Cost warning:** EC2, NAT gateway, public IPv4 and EBS can incur charges. Run `terraform destroy` after testing. Never upload Terraform state or SSH private keys.

## Configure Ansible
```bash
cd ../ansible
ansible-galaxy collection install -r requirements.yml
cp inventory.ini.example inventory.ini
cp group_vars/all.yml.example group_vars/all.yml
# Set public/private IPs from Terraform outputs, actual repo paths, Mongo credentials.
# Encrypt sensitive variables with Ansible Vault before committing anything.
ansible-playbook -i inventory.ini site.yml --syntax-check
ansible-playbook -i inventory.ini site.yml
```
Private host SSH uses `ProxyJump` through the public web EC2. Verify SSH trust and access first.

## Important verification notes
- **Unverified application-specific assumptions:** folder names `backend`, `frontend`; frontend `build`; `npm start`; backend port 5000; `MONGO_URI`; `/api` route. Inspect upstream application before live use.
- **Security caveat:** MongoDB role creates app user but does not create a dedicated admin user. Complete database hardening before production deployment.
- No actual AWS deployment, screenshots or runtime validation has been performed as part of this package.
- See `docs/IMPLEMENTATION_REPORT.md` for execution checklist and limitations.
