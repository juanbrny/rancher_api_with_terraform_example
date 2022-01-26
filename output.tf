
output "access_key_foo" {
    value = rancher2_token.auth.access_key
    #sensitive = true
}

output "secret_key_foo" {
    value = rancher2_token.auth.secret_key
    sensitive = true
}
