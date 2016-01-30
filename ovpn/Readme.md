# ovpn_maker.sh

It is easy to create *.ovpn files from template. So, you have already generated
`developer1.crt` and `developer1.key` and of course your `ca.key` and tls-auth
file.

```
cd easy-rsa-master/easyrsa3 # your rsa infrastucture dir
# first parameter is template file, the second is the name of key and the third
# is path to ta.key
ovpn_maker.sh template.ovpn developer1 ta.key > developer1.ovpn
```

Copy template from script comments, change your server address, port etc.
