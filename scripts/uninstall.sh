#!/bin/bash

cat ../web/art/rengine.txt
echo "Uninstalling reNgine"

if [ "$EUID" -ne 0 ]
  then
  echo "Error uninstalling reNgine, Please run this script as root!"
  echo "Example: sudo ./uninstall.sh"
  exit
fi

echo "Stopping reNgine"
docker stop scan-celery-1 scan-db-1 scan-celery-1 scan-celery-beat-1 scan-redis-1 scan-tor-1 scan-proxy-1 scan-web-1

echo "Removing all Containers related to reNgine"
docker rm scan-celery-1 scan-db-1 scan-celery-1 scan-celery-beat-1 scan-redis-1 scan-tor-1 scan-proxy-1 scan-web-1
echo "Removed all Containers"

echo "Removing All volumes related to reNgine"
docker volume rm scan_gf_patterns scan_github_repos scan_nuclei_templates scan_postgres_data scan_scan_results scan_tool_config scan_static_volume scan_wordlist
echo "Removed all Volumes"

echo "Removing all networks related to reNgine"
docker network rm scan_rengine_network scan_default
docker image rm nginx:alpine postgres:12.3-alpine redis:alpine scan_celery scan_celery-beat:latest scan_certs:latest docker.pkg.github.com/yogeshojha/rengine/rengine:latest peterdavehello/tor-socks-proxy:latest
echo "Finished Uninstalling."
