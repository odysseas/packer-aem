#!/usr/bin/env bash
set -o nounset
set -o errexit

yum -y upgrade

rpm -ivh --force https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum -y install puppet-agent epel-release

# Enable the rhui-REGION-rhel-server-optional to install ruby-devel
rpm -ivh --force https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum-config-manager --enable rhui-REGION-rhel-server-optional
yum-config-manager --enable rhui-REGION-rhel-server-extras
yum-config-manager --enable rhel-7-server-rhui-optional-rpms

# Install development tools needed to natively build Nokogiri (a dependency of ruby_aem)
# TODO: reduce the footprint and only install the ones required by Nokogiri
yum -y groupinstall 'Development Tools'
