# List all logs by time period
log = OneAndOne::Log.new()

response = log.list(period: 'LAST_24H')

puts JSON.pretty_generate(response)



# Returns information about a log
log = OneAndOne::Log.new()

response = log.get(log_id: '<LOG-ID>')

puts JSON.pretty_generate(response)