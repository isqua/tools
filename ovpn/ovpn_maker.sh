#!/usr/bin/env bash

# Default template
# client
# dev tun
# remote example.com
# resolv-retry infinite
# nobind
# persist-key
# persist-tun
# verb 1
# keepalive 10 120
# port 1194
# proto udp
# cipher BF-CBC
# comp-lzo
# remote-cert-tls server
# redirect-gateway
# key-direction 1
# <ca>
# ${ca}
# </ca>
# <cert>
# ${cert}
# </cert>
# <key>
# ${key}
# </key>
# <tls-auth>
# ${tlsauth}
# </tls-auth>

function get_key() {
	local keyfile="./pki/private/${1}.key"
	cat $keyfile
}

function get_cert() {
	local certfile="./pki/issued/${1}.crt"
	sed -n -e '/-----BEGIN CERTIFICATE-----/,$p' $certfile
}

function get_ca() {
	local certfile="./pki/ca.crt"
	cat $certfile
}

function get_tlsauth() {
	local tafile=$1
	cat $tafile
}

function generate_ovpn() {
	local template=$1
	local name=$2
	local ta=$3
	export ca=$(get_ca)
	export cert=$(get_cert $name)
	export key=$(get_key $name)
	export tlsauth=$(get_tlsauth $ta)
	envsubst < ${template}
}

generate_ovpn $@
