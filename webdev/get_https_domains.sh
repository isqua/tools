#!/bin/sh

get_cert() {
    DOMAIN=$1
    SERVER=$2
    echo | openssl s_client -servername $DOMAIN -connect $SERVER:443 2>/dev/null | openssl x509 -text
}

get_domains() {
    get_cert $@ | grep DNS | tr ',' '\n' | cut -d ':' -f 2
}

get_dns() {
    DOMAIN=$1
    host $DOMAIN
}

for d in $(get_domains $@); do
    echo "DNS for $d"
    get_dns $d
    echo
done
