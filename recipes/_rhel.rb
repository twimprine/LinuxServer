#
# Cookbook:: LinuxServer
# Recipe:: _rhel
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




#-------------------------------------------------------------------------------------
# Due to RHEL licensing issues and our lack of a satelite server I'm using this as
# a hack to keep our servers licensed so we can install and manage software

# Read data out of "accounts" data bag
account = data_bag_item('accounts', 'RHELSupport')
username = account['account']
password = account['password']

bash 'register' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    subscription-manager register --username #{username} --password #{password} --auto-attach --force
    EOH
  end

  if node['platform'] == 'redhat' and node['platform_version'].include? '7.'
    yum_package 'open-vm-tools' do
      action :install
    end
  end

  if node['platform'] == 'redhat' and node['platform_version'].include? '8.'
    yum_package 'open-vm-tools' do
      action :install
    end
  end
