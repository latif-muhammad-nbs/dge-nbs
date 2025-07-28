
# Azure AKS Deployment with Grafana, Front Door, and WAF

This Terraform-based project deploys a secure Azure Kubernetes Service (AKS) cluster with Grafana dashboard exposed over TLS using Azure Front Door and protected with Azure Web Application Firewall (WAF).

## 📌 Project Overview

This solution provisions the following infrastructure on Azure:

- **AKS Cluster** (via Terraform module)
- **Grafana** (deployed inside AKS)
- **Azure Front Door** with HTTPS and WAF rules
- **Self-signed or managed certificate** for TLS encryption

- ![DGE-grafana-](https://github.com/user-attachments/assets/cc590342-869c-4f3b-aa9a-5bead42617ed)


## 🔧 Prerequisites

Before you begin, ensure you have the following installed and configured:

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) (logged in via `az login`)
- [Terraform](https://developer.hashicorp.com/terraform/downloads) v1.3+
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- An active Azure subscription with Owner/Contributor access

## 📁 Project Structure

```
.
├── main.tf                  # Root module to call sub-modules
├── variables.tf             # Input variables
├── outputs.tf               # Output values
├── backend.tf               # Remote state backend (optional)
├── modules/
│   ├── aks/                 # AKS-specific Terraform configuration
│   ├── grafana/             # Grafana deployment on AKS
│   └── frontdoor/           # Azure Front Door configuration
```

## 🚀 Deployment Steps

1. **Login to Azure:**

```bash
az login
az account set --subscription "<your-subscription-id>"
```

2. **Initialize Terraform:**

```bash
terraform init
```

3. **Review the execution plan:**

```bash
terraform plan
```

4. **Apply the configuration:**

```bash
terraform apply
```

> This will provision the AKS cluster, deploy Grafana, and configure Azure Front Door with TLS/WAF protection.

## 🌐 Accessing Grafana

Once deployed, Grafana can be accessed via the Azure Front Door endpoint. TLS/HTTPS will be enforced and protected with WAF policies. You can find the public endpoint in the Terraform output.

## 🛡️ Security

- Azure Front Door uses WAF policies to mitigate common threats (OWASP Top 10).
- TLS encryption is enforced on all external endpoints.
- Role-based access control (RBAC) is applied within AKS.

## 📦 Cleanup

To delete all resources:

```bash
terraform destroy
```

---

## 📮 Contact

For questions or support, reach out to the DevOps team at `latif.muhammad@northbaysolutions.net`.
