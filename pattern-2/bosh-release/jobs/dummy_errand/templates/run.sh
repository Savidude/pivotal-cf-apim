#!/usr/bin/env bash

set -e

healthCheckEP="https://localhost:9443/publisher/site/pages/login.jag"

if curl --output /dev/null --silent --head --fail -k "$healthCheckEP"
then
    status_code=$(curl --write-out %{http_code} --silent --output /dev/null -k ${healthCheckEP})

    if [[ "$status_code" -ne 200 ]] ; then
        echo "WSO2APIm produces an invalid response: $status_code"
        exit 1
    else
        echo "WSO2APIM is Running!"
        exit 0
        fi
else
    echo "WSO2 APIM is not alive"
    exit 1
fi
