#!/bin/bash

RELEASE_NAME=$1
CLUSTER_ENDPOINT=$2

ATTEMPTS=0

check_helm_status() {
    helm status "$RELEASE_NAME"
    return $?
}

check_app_health() {
    curl -I -f -s -o /dev/null -w "/healthz: %{http_code}\n" http://$CLUSTER_ENDPOINT/healthz
    return $?
}

while [ $ATTEMPTS -lt 30 ]; do
    if check_helm_status && check_app_health; then
        echo "Helm status is 'deployed' and /healthz returned OK."
        exit 0
    fi

    sleep 1
    ((ATTEMPTS++))
done

echo "Health conditions were not met within the timeout, rolling back"

helm rollback $RELEASE_NAME

echo "Rollback complete"

helm history $RELEASE_NAME

exit 1
