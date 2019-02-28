#
# Cookbook:: LinuxServer
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

# Attribute Settings for associated cookbooks 

# NTP Settings
default['ntp']['restrict_default'] = 'restrict default limited kod nomodify'
default['ntp']['servers'] = ['ntp.xula.local']

# firewall cookbook attributes
default['firewall']['allow_ssh'] = true
default['firewall']['allow_winrm'] = true
default['firewall']['allow_mosh'] = false
default['firewall']['allow_loopback'] = true
default['firewall']['allow_icmp'] = true


# DNS Settings for resolver cookbook
default['resolver']['search'] = 'xula.local xavier.xula.local xula.edu'
default['resolver']['domain'] = node['domain']
default['resolver']['nameservers'] = ['10.49.20.30', '10.49.21.30']
default['resolver']['options'] = {
  'rotate' => nil
}

# syslog settings
default['rsyslog']['server_ip'] = "10.80.10.12", "10.80.24.150"
default['rsyslog']['action_queue_max_disk_space'] = '5G'

# postfix settings


