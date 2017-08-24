#!/usr/bin/env bash

set -euo pipefail

function sql() {
  kubectl exec "cockroachdb-${1}" -- /cockroach/cockroach sql \
      --host "cockroachdb-${1}.cockroachdb" \
      --insecure \
      -e "$(cat /dev/stdin)"
}

# Create database and user with priveleges.
cat <<EOF | sql 0
CREATE DATABASE IF NOT EXISTS k8s_community;
CREATE DATABASE IF NOT EXISTS github_integration;
CREATE USER {{ k8s_community_db_username }} WITH PASSWORD '{{ k8s_community_db_password }}';
CREATE USER {{ k8s_github_integration_db_username }} WITH PASSWORD '{{ k8s_github_integration_db_password }}';
GRANT ALL ON DATABASE k8s_community TO {{ k8s_community_db_username }};
GRANT ALL ON DATABASE github_integration TO {{ k8s_github_integration_db_username }};
EOF
