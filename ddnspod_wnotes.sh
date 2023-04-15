#!/bin/bash

#Variables here
RECORD_TYPE='AAAA'
TOKEN="401929,4c68dd7029d33dcc2bf0ca7cadd58413"
MAIL="mayne.info"
PASS="lenovo"
NETDEVICE="wlp3s0"

#Get local real IPv6 address
ip_address() {
    ip addr show dev ${NETDEVICE} | sed -e's/^.*inet6 \([^ ]*\)\/.*$/\1/;t;d' | awk 'NR==1'
}
echo "Local IPv6: $(ip_address)"

#API response
api_post() {
    local inter="https://dnsapi.cn/${1}"
    if [ -n "$TOKEN" ]; then
        local param="login_token=${TOKEN}&format=json&${2}"
    else
        local param="login_email=${MAIL}&login_password=${PASS}&format=json&${2}"
    fi
    local agent="curl/7.81.0"
    curl -sS -X POST "$inter" -d "$param" -H "User-Agent: $agent"
}

#Get domain info and record info and return the record IP address on DNSPod
ddns_info() {
    local domain_id record_id record_ip
    domain_id=$(api_post "Domain.Info" "domain=${1}" | jq -r '.domain.id')
    record_id=$(api_post "Record.List" "domain_id=${domain_id}&sub_domain=${2}&record_type=${RECORD_TYPE}" | jq -r '.records[0].id')
    record_ip=$(api_post "Record.Info" "domain_id=${domain_id}&record_id=${record_id}&record_type=${RECORD_TYPE}" | jq -r '.record.value')
    [ -n "$record_ip" ] && echo "$record_ip" || echo "Get Record Info Failed!"
}

#Update domain record IP address on DNSPod
ddns_update() {
    local domain_id record_id
    domain_id=$(api_post "Domain.Info" "domain=${1}" | jq -r '.domain.id')
    record_id=$(api_post "Record.List" "domain_id=${domain_id}&record_type=${RECORD_TYPE}&sub_domain=${2}" | jq -r '.records[0].id')
    if [ "$(api_post "Record.Modify" "domain_id=${domain_id}&sub_domain=${2}&record_type=${RECORD_TYPE}&record_id=${record_id}&record_line=默认&value=$(ip_address)" | jq -r '.status.code')" = "1" ]; then
        ddns_info "$1" "$2"
        return 0
    else
        echo "Update Failed!"
        return 1
    fi
}

#Check and update domain record IP address on DNSPod
ddns_check() {
    local last_ip
    local host_ip=$(ip_address)
    echo "Updating Domain: ${2}.${1}"
    echo "hostIP: ${host_ip}"
    last_ip=$(ddns_info "$1" "$2")
    if [ $? -eq 0 ]; then
        echo "lastIP: ${last_ip}"
        if [ "$last_ip" != "$host_ip" ]; then
            if ddns_update "$1" "$2"; then
                echo "Update to ${host_ip} succeeded."
                return 0
            else
                echo "Update Failed!"
                return 1
            fi
        fi
        echo "No IP change since your last IP record"
        return 0
    fi
    echo ${last_ip}
    return 1
}

ddns_check "mayne.info" "lenovo"
