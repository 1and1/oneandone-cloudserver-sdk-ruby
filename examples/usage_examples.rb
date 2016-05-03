# List all usages by time period
usage = OneAndOne::Usage.new()

response = usage.list(period: 'LAST_24H')

puts JSON.pretty_generate(response)