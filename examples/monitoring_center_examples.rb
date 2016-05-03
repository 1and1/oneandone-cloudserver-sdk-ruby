# List all usages and alerts of monitoring servers
monitoring_center = OneAndOne::MonitoringCenter.new()

response = monitoring_center.list

puts JSON.pretty_generate(response)



# Returns the usage of the resources for the specified time range
monitoring_center = OneAndOne::MonitoringCenter.new()

response = monitoring_center.get(server_id: '<SERVER-ID>', period: 'LAST_24H')

puts JSON.pretty_generate(response)