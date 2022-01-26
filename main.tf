
terraform {
  required_providers {
    rancher2 = {
      source = "rancher/rancher2"
      version = "1.22.2"
    }
  }
}

provider "rancher2" {
  api_url   = var.rancher_url
  token_key = var.rancher_api_key
  insecure = true
  timeout     = "15m"
}


resource "rancher2_token" "auth" {
  provider = rancher2
  ttl = 1200
}


resource "null_resource" "configure_keycloak_oidc" {
  provisioner "local-exec" {
      command = <<EOT
       curl -k --insecure -u '${rancher2_token.auth.access_key}:${rancher2_token.auth.secret_key}'  \
        -X PUT \
        -H 'Accept: application/json' \
        -H 'Content-Type: application/json' \
        -d '{    "accessMode": "unrestricted",    "allowedPrincipalIds": [        "keycloakoidc_user://4b8c66e7-7989-44ba-bf40-1d362986ac0b"    ],    "authEndpoint": "http://192.168.223.147:8080/auth/realms/rancher/protocol/openid-connect/auth",    "clientId": "rancher26",    "created": "2021-09-12T17:08:02Z",    "creatorId": null,    "enabled": true,    "groupSearchEnabled": null,    "issuer": "http://192.168.223.147:8080/auth/realms/rancher",    "labels": {        "cattle.io/creator": "norman"    },    "name": "keycloakoidc",    "ownerReferences": [ ],    "rancherUrl": "https://rancher26.home.brainy.es/verify-auth",    "scope": "openid profile email",    "type": "keyCloakOIDCConfig",    "uuid": "9641a9cd-bc12-4309-83cc-cdf9f7bb2b1c"}' \
       ${var.rancher_url}/v3/keyCloakOIDCConfigs/keycloakoidc?action=testAndApply

EOT
  }
}
