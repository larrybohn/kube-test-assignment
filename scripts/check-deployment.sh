#!/bin/bash

RELEASE_NAME="prime-api"

TIME_LIMIT=30
TIME_ELAPSED=0

check_helm_status() {
    helm status "$RELEASE_NAME" > /dev/null 2>&1
    return $?
}

check_port() {
    nc -zv kube-test-assignment-cluster.eastus.cloudapp.azure.com 80 > /dev/null 2>&1
    return $?
}

# Wait loop to check conditions for up to 30 seconds
while [ $TIME_ELAPSED -lt $TIME_LIMIT ]; do
    # Check Helm status
    if check_helm_status; then
        echo "Helm release '$RELEASE_NAME' is deployed."
    else
        echo "Helm release '$RELEASE_NAME' is not deployed."
    fi

    # Check if port 80 is open
    if check_port; then
        echo "Port 80 is open."
    else
        echo "Port 80 is not open."
    fi

    # If both conditions are met, exit
    if check_helm_status && check_port; then
        echo "Conditions met. Both Helm status is 'deployed' and port 80 is open."
        exit 0
    fi

    # Sleep for 1 second before rechecking
    sleep 1
    ((TIME_ELAPSED++))
done

echo "Conditions were not met within $TIME_LIMIT seconds."
exit 1
