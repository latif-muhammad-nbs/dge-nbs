# modules/grafana/variables.tf

variable "kubernetes_namespace" {
  description = "The Kubernetes namespace where Grafana will be deployed."
  type        = string
  default     = "monitoring"
}

# Optional: Variables for Grafana customization
/*
variable "grafana_admin_user" {
  description = "Grafana admin username."
  type        = string
  default     = "admin"
}

variable "grafana_admin_password" {
  description = "Grafana admin password. Use a secure method (e.g., Key Vault) in production."
  type        = string
  sensitive   = true # Mark as sensitive to prevent showing in logs
  # You should generate this securely, e.g., with random_password resource or retrieve from Key Vault.
}

variable "grafana_helm_chart_version" {
  description = "Version of the Grafana Helm chart to deploy."
  type        = string
  default     = "6.50.0" # Check for the latest stable version
}
*/