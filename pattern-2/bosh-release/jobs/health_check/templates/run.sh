#!/usr/bin/env bash

set -e

health_check() {
    # Check if health check endpoint is alive
    if curl --output /dev/null --silent --head --fail -k "$1"
    then
        status_code=$(curl --write-out %{http_code} --silent --output /dev/null -k ${1})

        # Check if requests to the health check endpoint produces  200 response
        if [[ "$status_code" -ne 200 ]] ; then
            echo "WSO2 APIM $2 produces an invalid response: $status_code" >>/dev/stderr
            exit 1
        else
            echo "WSO2 APIM $2 is Running!"
        fi
    else
        echo "WSO2 APIM $2 is not alive" >>/dev/stderr
        exit 1
    fi
}

publisherHealthCheckEP="https://localhost:9443/publisher/site/pages/login.jag"
storeHealthCheckEP="https://localhost:9443/store/site/pages/login.jag"

health_check ${publisherHealthCheckEP} Publisher
health_check ${storeHealthCheckEP} Store
exit 0