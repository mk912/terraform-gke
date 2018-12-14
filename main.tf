terraform {
  required_version = ">= 0.11.0"
}
# Define the login method
provider "google" {
  credentials = "${file("./credentials/dev-k8s-01-474791d4ea07.json")}"
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}

# Setup and bootstrap the k8s (gke) cluster
resource "google_container_cluster" "demo-k8s" {
  name               = "${var.cluster_name}"
  description        = "demo gke cluster"
  zone               = "${var.gcp_zone}"
  additional_zones   = "${var.gcp_other_zone}"
  initial_node_count = "${var.initial_node_count}"
  enable_kubernetes_alpha = "true"
  enable_legacy_abac = "true"
  min_master_version = "${var.master_version}"
  node_version       = "${var.worker_version}"

  master_auth {
    username = "${var.master_username}"
    password = "${var.master_password}"
  }

  node_config {
    machine_type = "${var.node_machine_type}"
    disk_size_gb = "${var.node_disk_size}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}

# Get cluster credentials
provider "kubernetes" {
  host = "https://${google_container_cluster.demo-k8s.endpoint}"
  username = "${google_container_cluster.demo-k8s.master_auth.0.username}"
  password = "${google_container_cluster.demo-k8s.master_auth.0.password}"
  client_certificate = "${base64decode(google_container_cluster.demo-k8s.master_auth.0.client_certificate)}"
  client_key = "${base64decode(google_container_cluster.demo-k8s.master_auth.0.client_key)}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.demo-k8s.master_auth.0.cluster_ca_certificate)}"

}

# # Create namepaces using loop for variable.tf
# resource "kubernetes_namespace" "ns" {
#   count = "${length(var.list_namespace)}"
#   metadata {
#     name = "${element(var.list_namespace,count.index%length(var.list_namespace))}"
#   }
# }

# Deploy apps and database from yaml files
# resource "null_resource" "deploy_apps" {
#   provisioner "local-exec" {
#     command = "kubectl apply -f apps_repo"
#   }
# }
