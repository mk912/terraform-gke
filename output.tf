# The following outputs allow authentication and connectivity to the GKE Cluster.
output "k8s_endpoint" {
  value = "${google_container_cluster.demo-k8s.endpoint}"
}

output "k8s_master_version" {
  value = "${google_container_cluster.demo-k8s.master_version}"
}

output "k8s_instance_group_urls" {
  value = "${google_container_cluster.demo-k8s.instance_group_urls.0}"
}

output "client_certificate" {
  value = "${google_container_cluster.demo-k8s.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.demo-k8s.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.demo-k8s.master_auth.0.cluster_ca_certificate}"
}

output "kubconfig" {
  value = " ... \nRun command to configure access via kubectl:\n$ gcloud container clusters get-credentials ${var.cluster_name} --zone ${var.gcp_zone} --project ${var.gcp_project}"
}
