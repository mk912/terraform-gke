variable "gcp_project" {
  description = "GCP project name"
  default  = "dev-k8s-01"
}

variable "gcp_region" {
  description = "GCP region, e.g. us-east1"
  default = "northamerica-northeast1"
}

variable "gcp_zone" {
  description = "GCP zone, e.g. us-east1-a (which must be in gcp_region)"
  default = "northamerica-northeast1-a"
}

variable "gcp_other_zone" {
  description = "GCP list of other zone, e.g. us-east1-b, us-east1-c"
  default = ["northamerica-northeast1-b", "northamerica-northeast1-c"]
}

variable "cluster_name" {
  description = "Name of the K8s cluster"
  default = "demogke"
}

variable "initial_node_count" {
  description = "Number of worker VMs to initially create"
  default = 1
}

variable "worker_version" {
  default = "1.11.2-gke.20"
}

variable "master_version" {
  default = "1.11.2-gke.20"
}

variable "master_username" {
  description = "Username for accessing the Kubernetes master endpoint"
  default = "r00t"
}

variable "master_password" {
  description = "Password for accessing the Kubernetes master endpoint"
}

variable "node_machine_type" {
  description = "GCE machine type"
  default = "n1-standard-2"
}

variable "node_disk_size" {
  description = "Node disk size in GB"
  default = "50"
}

variable "environment" {
  description = "value passed to ACS Environment tag"
  default = "dev"
}

# variable "list_namespace" {
#   description = "List of namespace to create"
#   default = [
#     "infra",
#     "infra-devops",
#     "dev-ops"
#   ]
# }
