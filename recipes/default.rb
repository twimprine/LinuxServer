#
# Cookbook:: LinuxServer
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright:: 2017, Thomas Wimprine
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Not happy about this but we don't have a good handle on what's running so
# configuring the firewall properly is almost impossible at this time. And it's
# configured by default so for now it needs to go... :/

include_recipe 'firewall::disable_firewall'

service 'firewalld' do
  action :stop
end


# Obviously we need chef-client to run :)
include_recipe 'chef-client::default'

#--------------------------------------------------------------------------------------
# Basic format is to call the recipe for configuration then the firewall ports to
# be open for the service if needed.

if node['platform_family'] == 'rhel' and node['platform'] != 'centos'
  include_recipe 'LinuxServer::_rhel'
end

#-----------------------------------------------------------------------------
# hostfile entries so that the system can always find the chef server
# sometimes the resolv.conf file is changed on boot - this gets corrected
# when the recipe runs IF if can find the chef server, otherwise the system
# just sits and spins fans...

hostsfile_entry '10.80.10.5' do
    hostname 'xuvuchef001'
    aliases ['xuvuchef001.xavier.xula.local', 'xuvuchef001.xula.local']
    action  :create
    comment 'Added to host file by chef to ensure recipes work if DNS is down'
end

hostsfile_entry '10.49.5.10' do
   hostname 'xuvuchef002'
   aliases ['xuvuchef002.xavier.xula.local', 'xuvuchef002.xula.local']
   action :create
   comment 'Added to host file by Chef to ensure resolution in case of DNS issue'
end

hostsfile_entry '10.49.22.131' do
   hostname 'xuvurmq001'
   aliases ['xuvurmq001.xula.local', 'xuvurmq001.xula.edu']
   action :create
   comment 'Added by Chef for RabbitMQ'
end

hostsfile_entry '10.49.22.132' do
   hostname 'xuvurmq002'
   aliases ['xuvurmq002.xula.local', 'xuvurmq002.xula.edu']
   comment 'Added by Chef for RabbitMQ'
   action :create
end

hostsfile_entry '10.49.22.133' do
   hostname 'xuvurmq003'
   aliases ['xuvurmq003.xula.local', 'xuvurmq003.xula.edu']
   action :create
   comment 'Added by Chef for RabbitMQ'
end

hostsfile_entry '10.49.22.134' do
   hostname 'xuvurmq004'
   aliases ['xuvurmq004.xula.local', 'xuvurmq004.xula.edu']
   comment 'Added by Chef for RabbitMQ'
   action :create
end

hostsfile_entry '10.49.12.131' do
  hostname 'xuvudevrmq001'
  aliases ['xuvudevrmq001.xula.local', 'xuvudevrmq001.xula.edu']
  action :create
  comment 'Added by Chef for RabbitMQ'
end

hostsfile_entry '10.49.12.132' do
  hostname 'xuvudevrmq002'
  aliases ['xuvudevrmq002.xula.local', 'xuvudevrmq002.xula.edu']
  action :create
  comment 'Added by Chef for RabbitMQ'
end





#------------------------------------------------------------------------------
# Create MOTD login screen
cookbook_file '/etc/motd' do
  source 'motd'
  mode    '0444'
  owner   'root'
  action  :create
end

# Install open-vm-tools on centos 7+
if node['platform'] == 'centos' and node['platform_version'].include? '7.'
  yum_package 'open-vm-tools' do
    action :install
  end
end

# Update CentOS Linux servers
# if node['platform'] == 'centos'
#   include_recipe 'yum-cron::default'
# end

include_recipe 'yum-cron::default'

#------------------------------------------------------------------------------
# Add ssh keys for root user
# Edit properties in attributes file
#-----------------------------------------------------------------------------
# %w(twimprin).each do |key|
#     sshkeys = data_bag_item('sshuserkeys', #{key})
#     file '/root/.ssh/authorized_keys' do
#         backup          true
#         owner           root
#         atomit_update   true
#         content         sshkeys['ssh_keys']
#     end
# end

#-----------------------------------------------------------------------------
# Global firewall settings

# Disabled firewall changes until we can properly troubleshoot

#include_recipe 'firewall::default'

#firewall 'default' do
#    log_level :high
#    action :install
#    enabled_zone :internal
#end

#-----------------------------------------------------------------------------
# update the list of DNS servers
include_recipe 'resolver::default'

#-----------------------------------------------------------------------------

include_recipe 'ntp::default'
# NTP Servers belong to the Chef NTPServer role

#firewall_rule 'ntp' do
#    port    123
#    protocol :udp
#    command :allow
#    action :create
#end

#-----------------------------------------------------------------------------

include_recipe 'xula_snmp::default'

#firewall_rule 'snmp' do
#    port    161
#    protocol :tcp
#    command :allow
#    action :create
#end

# Collect all the logs

include_recipe 'rsyslog::client'

# Configure mail on all the clients to be properly relayed
include_recipe 'postfix::client'

# Harden the OS a bit
#include_recipe 'os-hardening'

# ---------------------------------------------------------------------------
# Evidently I need to update the clients more often
# this seems to be working in tests so...
# -------------------------------------------------------------------------

include_recipe 'chef_client_updater'
