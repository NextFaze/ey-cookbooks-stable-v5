ey_cloud_report "haproxy" do
  message 'processing haproxy'
end

execute 'fix_loadbalancers' do
  command 'ethtool -K eth0 tso on sg on'
end

# We do the configure first so we get the correct config.
# The install recipe expects to be called second
# and will likely fail on clean instances if it's put first
require_recipe 'haproxy::kill-others'
require_recipe 'haproxy::configure'
require_recipe 'haproxy::install'
