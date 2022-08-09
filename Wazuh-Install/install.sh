#!/usr/bin/env bash
# @author: O5t3 A simple script to auto install wazuh components: i.e, Wazuh Indexer, Wazuh Server & Wazuh Dashboard

function indexer() {
	curl -sO https://packages.wazuh.com/4.3/wazuh-install.sh && curl -sO https://raw.githubusercontent.com/05t3/Bash-Scripts/main/Wazuh-Install/config.yml && bash wazuh-install.sh --generate-config-files && cp wazuh-install-files.tar /opt && curl -sO https://packages.wazuh.com/4.3/wazuh-install.sh && bash wazuh-install.sh --wazuh-indexer node-1 && bash wazuh-install.sh --start-cluster
}
function server() {
	curl -sO https://packages.wazuh.com/4.3/wazuh-install.sh && bash wazuh-install.sh --wazuh-server wazuh-1 
}
function dashboard() {
	bash wazuh-install.sh --wazuh-dashboard dashboard
}
function service() {
	systemctl list-units --type=service --state=running | egrep "filebeat.service|wazuh-dashboard.service|wazuh-indexer.service|wazuh-manager.service"
}
function install() {
	indexer server dashboard service
}
