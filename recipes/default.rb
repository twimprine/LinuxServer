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

# Basic format is to call the recipe for configuration then the firewall ports to 
# be open for the service if needed.

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

#firewall_rule 'ntp' do
#    port    123
#    protocol :udp
#    command :allow
#    action :create
#end

#-----------------------------------------------------------------------------

include_recipe 'snmp::default'

#firewall_rule 'snmp' do
#    port    161
#    protocol :tcp
#    command :allow
#    action :create
#end