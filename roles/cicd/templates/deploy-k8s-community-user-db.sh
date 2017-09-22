#!/usr/bin/env bash

set -euo pipefail

# Drop users if they already exist
function user_rm() {
  kubectl exec -n k8s-community "cockroachdb-${1}" -- /cockroach/cockroach user rm ${2} \
      --host "cockroachdb-${1}.cockroachdb" \
      --insecure
}

user_rm 0 {{ k8s_community_db_username }}
user_rm 0 {{ k8s_github_integration_db_username }}

# Create database and user with priveleges.
function sql() {
  kubectl exec -n k8s-community "cockroachdb-${1}" -- /cockroach/cockroach sql \
      --host "cockroachdb-${1}.cockroachdb" \
      --insecure \
      -e "$(cat /dev/stdin)"
}

cat <<EOF | sql 0
CREATE DATABASE IF NOT EXISTS k8s_community;
CREATE DATABASE IF NOT EXISTS github_integration;
CREATE USER {{ k8s_community_db_username }} WITH PASSWORD '{{ k8s_community_db_password }}';
CREATE USER {{ k8s_github_integration_db_username }} WITH PASSWORD '{{ k8s_github_integration_db_password }}';
GRANT ALL ON DATABASE k8s_community TO {{ k8s_community_db_username }};
GRANT ALL ON DATABASE github_integration TO {{ k8s_github_integration_db_username }};
EOF
