output "cluster_id" {
  value       = data.rancher2_cluster.local.id
  description = "Rancher local cluster id"
}

output "access_key_foo" {
    value = rancher2_token.auth.access_key
    #sensitive = true
}

output "secret_key_foo" {
    value = rancher2_token.auth.secret_key
    sensitive = true
}
