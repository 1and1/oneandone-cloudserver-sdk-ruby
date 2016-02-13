require_relative 'oneandone'

OneAndOne.start('<API-TOKEN>')




# List all monitoring policies on your account
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.list

puts JSON.pretty_generate(response)



# Create a monitoring policy
monitoring_policy = OneAndOne::MonitoringPolicy.new()

### Create threshold limits
thresholds = {
  'cpu' => {
    'warning' => {
      'value' => 90,
      'alert' => false
    },
    'critical' => {
      'value' => 95,
      'alert' => false
    }
  },
  'ram' => {
    'warning' => {
      'value' => 90,
      'alert' => false
    },
    'critical' => {
      'value' => 95,
      'alert' => false
    }
  },
  'disk' => {
    'warning' => {
      'value' => 90,
      'alert' => false
    },
    'critical' => {
      'value' => 95,
      'alert' => false
    }
  },
  'transfer' => {
    'warning' => {
      'value' => 1000,
      'alert' => false
    },
    'critical' => {
      'value' => 2000,
      'alert' => false
    }
  },
  'internal_ping' => {
    'warning' => {
      'value' => 50,
      'alert' => false
    },
    'critical' => {
      'value' => 100,
      'alert' => false
    }
  }
}

### Add ports
port1 = {
  'protocol' => 'TCP',
  'port' => 80,
  'alert_if' => 'NOT_RESPONDING',
  'email_notification' => true
}

ports = [port1]

### Add processes
process1 = {
  'process' => 'test',
  'alert_if' => 'NOT_RUNNING',
  'email_notification' => true
}

processes = [process1]

response = monitoring_policy.create(name: 'Test Monitoring Policy',
  email: 'test@example.com', agent: true, thresholds: thresholds, ports: ports,
  processes: processes)

puts JSON.pretty_generate(response)



# Returns a monitoring policy's current specs
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.get(monitoring_policy_id: '<MONITORING-POLICY-ID>')

puts JSON.pretty_generate(response)



# Modify a monitoring policy and its thresholds
monitoring_policy = OneAndOne::MonitoringPolicy.new

new_thresholds = {
  'cpu' => {
    'warning' => {
      'value' => 80,
      'alert' => false
    },
    'critical' => {
      'value' => 85,
      'alert' => false
    }
  },
  'ram' => {
    'warning' => {
      'value' => 80,
      'alert' => false
    },
    'critical' => {
      'value' => 85,
      'alert' => false
    }
  },
  'disk' => {
    'warning' => {
      'value' => 80,
      'alert' => false
    },
    'critical' => {
      'value' => 85,
      'alert' => false
    }
  },
  'transfer' => {
    'warning' => {
      'value' => 750,
      'alert' => false
    },
    'critical' => {
      'value' => 1250,
      'alert' => false
    }
  },
  'internal_ping' => {
    'warning' => {
      'value' => 75,
      'alert' => true
    },
    'critical' => {
      'value' => 90,
      'alert' => true
    }
  }
}

response = monitoring_policy.modify(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  name: 'New Name', thresholds: new_thresholds)

puts JSON.pretty_generate(response)



# Delete a monitoring policy
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.delete(monitoring_policy_id: '<MONITORING-POLICY-ID>')

puts JSON.pretty_generate(response)



# List a monitoring policy's ports
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.ports(monitoring_policy_id: '<MONITORING-POLICY-ID>')

puts JSON.pretty_generate(response)



# Add ports to a monitoring policy
monitoring_policy = OneAndOne::MonitoringPolicy.new()

port2 = {
  'protocol' => 'TCP',
  'port' => 90,
  'alert_if' => 'NOT_RESPONDING',
  'email_notification' => true
}

ports = [port2]

response = monitoring_policy.add_ports(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  ports: ports)

puts JSON.pretty_generate(response)



# Returns information about a monitoring policy's port
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.port(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  port_id: '<PORT-ID>')

puts JSON.pretty_generate(response)



# Delete a monitoring policy's port
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.delete_port(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  port_id: '<PORT-ID>')

puts JSON.pretty_generate(response)



# Modify a monitoring policy's port
monitoring_policy = OneAndOne::MonitoringPolicy.new()

port = {
  'protocol' => 'TCP',
  'port' => 80,
  'alert_if' => 'RESPONDING',
  'email_notification' => false
}

response = monitoring_policy.modify_port(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  port_id: '<PORT-ID>', new_port: port)

puts JSON.pretty_generate(response)



# List a monitoring policy's processes
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.processes(monitoring_policy_id: '<MONITORING-POLICY-ID>')

puts JSON.pretty_generate(response)



# Returns information about a monitoring policy's process
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.process(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  process_id: '<PROCESS-ID>')

puts JSON.pretty_generate(response)




# Add processes to a monitoring policy
monitoring_policy = OneAndOne::MonitoringPolicy.new()

process2 = {
  'process' => 'logger',
  'alert_if' => 'NOT_RUNNING',
  'email_notification' => true
}

processes = [process2]

response = monitoring_policy.add_processes(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  processes: processes)

puts JSON.pretty_generate(response)



# Modify a monitoring policy's process
monitoring_policy = OneAndOne::MonitoringPolicy.new()

process = {
  'process' => 'test',
  'alert_if' => 'RUNNING',
  'email_notification' => false
}

response = monitoring_policy.modify_process(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  process_id: '<PROCESS-ID>', new_process: process)

puts JSON.pretty_generate(response)



# Delete a monitoring policy's process
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.delete_process(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  process_id: '<PROCESS-ID>')

puts JSON.pretty_generate(response)



# List a monitoring policy's servers
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.servers(monitoring_policy_id: '<MONITORING-POLICY-ID>')

puts JSON.pretty_generate(response)



# Returns information about a monitoring policy's server
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.server(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Add servers to a monitoring policy
monitoring_policy = OneAndOne::MonitoringPolicy.new()

server1 = '<SERVER-ID>'

servers = [server1]

response = monitoring_policy.add_servers(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  servers: servers)

puts JSON.pretty_generate(response)



# Remove a monitoring policy's server
monitoring_policy = OneAndOne::MonitoringPolicy.new()

response = monitoring_policy.remove_server(monitoring_policy_id: '<MONITORING-POLICY-ID>',
  server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)