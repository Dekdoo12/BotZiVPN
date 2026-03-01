#!/bin/bash

# URUTAN TAMPILAN (ini yang menentukan urutan)
server_order=(
  "ID-BIZNET-1"
  "ID-BIZNET-2"
  "ID-BIZNET-3"
  "SG-NEWMEDIA"
)

# Alias => domain (domain tidak ditampilkan)
declare -A servers=(
  ["ID-BIZNET-1"]="zivpn.supercepat.biz.id"
  ["ID-BIZNET-2"]="103.197.190.193"
  ["ID-BIZNET-3"]="biznet2.supercepat.biz.id"
  ["SG-NEWMEDIA"]="newmedia.supercepat.biz.id"
)

# Port + label
declare -A ports=(
  [22]="VPS LOGIN"
)

green="\e[32m"; red="\e[31m"; nc="\e[0m"

echo "🔍 Cek status server"
echo "-------------------------------------------"

for alias in "${server_order[@]}"; do
  host="${servers[$alias]}"
  echo -e "\n🌐 Server: $alias"

  port=22
  timeout 2 bash -c "</dev/tcp/$host/$port" &>/dev/null
  if [[ $? -eq 0 ]]; then
    echo -e "  Port $port (${ports[$port]}): ${green}OPEN${nc}"
  else
    echo -e "  Port $port (${ports[$port]}): ${red}CLOSED${nc}"
  fi
done
