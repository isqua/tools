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
# ${ca}
# ${cert}
# ${key}
# ${tlsauth}

TOP_PID=$$

function get_file_content() {
	local file="$1"

	if [[ -r $file ]]; then
		cat $file
	else
		>&2 echo "Unable to read file: $file"
		kill -s TERM $TOP_PID
	fi
}

function get_key() {
	local keyfile="./pki/private/${1}.key"
	content=$(get_file_content $keyfile)

	if [[ -n "$content" ]]; then
		echo -e "<key>\n${content}\n</key>"
	fi
}

function get_cert() {
	local certfile="./pki/issued/${1}.crt"
	content=$(get_file_content $certfile | sed -n -e '/-----BEGIN CERTIFICATE-----/,$p')

	if [[ -n "$content" ]]; then
		echo -e "<cert>\n${content}\n</cert>"
	fi
}

function get_ca() {
	local certfile="./pki/ca.crt"
	content=$(get_file_content $certfile)

	if [[ -n "$content" ]]; then
		echo -e "<ca>\n${content}\n</ca>"
	fi
}

function get_tlsauth() {
	local tafile=$1
	content=$(get_file_content $tafile)

	if [[ -n "$content" ]]; then
		echo -e "<tls-auth>\n${content}\n</tls-auth>"
	fi
}

function generate_ovpn() {
	local template=$1
	local name=$2
	local ta=$3

	export ca=$(get_ca)
	export cert=$(get_cert $name)
	export key=$(get_key $name)
	export tlsauth="" 

	if [[ -n "$ta" && -r "$ta" ]]; then
		tlsauth=$(get_tlsauth $ta)
	fi
	
	envsubst < $template
}

generate_ovpn $@
