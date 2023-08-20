#!/bin/bash

uuidgenID="$(uuidgen)"

linode-cli linodes create \
  --image 'linode/ubuntu22.04' \
  --region eu-central \
  --type g6-nanode-1 \
  --label "${uuidgenID}" \
  --tags v2ray \
  --root_pass "$(pass linode-v2ray-servers-root)" \
  --authorized_users ************* \
  --booted true \
  --backups_enabled false \
  --private_ip true \
  --stackscript_id 1141993 \
  --stackscript_data '{}'


read -r -p "Enter the IP address of the new Linode: " linodeIP

echo -e "[remmina]
name=${uuidgenID}
labels=v2ray-frankfurt-linode
ssh_auth=3
server=${linodeIP}
group=vpn
username=root
protocol=SSH" > ~/.local/share/remmina/vpn_ssh_"${uuidgenID}".remmina

echo -e "[remmina]
username=MagnesiumNitrate
server=http://${linodeIP}:40402
name=${uuidgenID}
password=PotassiumPPotassium
labels=v2ray-frankfurt-linode
group=vpn
protocol=WWW" > ~/.local/share/remmina/vpn_www_"${uuidgenID}"_http---"$(echo "${linodeIP}" | sed 's/\./-/g')".remmina
