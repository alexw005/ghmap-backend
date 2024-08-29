#!/bin/bash

read -p 'Enter GitHub Client ID: ' clientIDVar
read -p 'Enter GitHub Client Secret: ' clientSecretVar


kubectl create ns oauth

kubectl apply -f - << EOF
apiVersion: v1
kind: Secret
metadata:
  name: github-oauth-secret
  namespace: oauth
type: Opaque
stringData:
  OAUTH2_PROXY_CLIENT_ID: "$clientIDVar"
  OAUTH2_PROXY_CLIENT_SECRET: "$clientSecretVar"
  OAUTH2_PROXY_COOKIE_SECRET: "$(openssl rand -hex 12)"
EOF