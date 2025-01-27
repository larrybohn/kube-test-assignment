#!/bin/bash

RELEASE_NAME="prime-api"

ATTEMPTS=0

check_helm_status() {
    helm status "$RELEASE_NAME" > /dev/null 2>&1
    return $?
}

check_port() {
    nc -zv localhost 8080 > /dev/null 2>&1
    return $?
}

kubectl port-forward svc/prime-api 8080:8080 &

# Wait loop to check conditions for up to 30 seconds
while [ $ATTEMPTS -lt 30 ]; do
    # Check Helm status
    if check_helm_status; then
        echo "Helm release '$RELEASE_NAME' is deployed."
    else
        echo "Helm release '$RELEASE_NAME' is not deployed."
    fi

    if check_port; then
        echo "Port 8080 is open."
    else
        echo "Port 8080 is not open."
    fi

    # If both conditions are met, exit
    if check_helm_status && check_port; then
        echo "Helm status is 'deployed' and port 8080 is open."
        exit 0
    fi

    # Sleep for 1 second before rechecking
    sleep 1
    ((ATTEMPTS++))
done

echo "Conditions were not met within the timeout."
exit 1
