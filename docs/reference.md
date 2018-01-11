# 1&amp;1 Ruby SDK


# Table of Contents

- ["wait_for"](#wait-for)
- [Class Attributes](#attributes)
- [Servers](#servers)
- [Images](#images)
- [Shared Storages](#shared-storages)
- [Firewall Policies](#firewall-policies)
- [Load Balancers](#load-balancers)
- [Public IPs](#public-ips)
- [Private Networks](#private-networks)
- [Monitoring Center](#monitoring-center)
- [Monitoring Policies](#monitoring-policies)
- [Logs](#logs)
- [Users](#users)
- [Usages](#usages)
- [Server Appliances](#server-appliances)
- [DVD's](#dvds)
- [Data Centers](#datacenters)
- [Pricing](#pricing)
- [Ping](#ping)
- [Ping Auth](#ping-auth)
- [VPN's](#vpn)
- [Roles](#roles)
- [SSH Keys](#ssh-keys)


# <a name="wait-for"></a>"wait_for"

Use the `wait_for()` method on any major class object to poll its resource until an `"ACTIVE"`, `"ENABLED"`, `"POWERED_ON"`, or `"POWERED_OFF"` state is returned.  This is necessary when chaining together multiple actions that take some time to deploy.  The `wait_for()` method is available on the `Server`, `Image`, `SharedStorage`, `Vpn`, `FirewallPolicy`, `LoadBalancer`, `PrivateNetwork`, and `MonitoringPolicy` classes.  It returns a hash containing the execution duration.  See the example below:
```
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API key


# Create a Server
server = OneAndOne::Server.new

hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

server1 = server.create(name: 'Example App Server',
                        vcore: 1,
                        cores_per_processor: 1,
                        ram: 1,
                        appliance_id: '<IMAGE-ID>',
                        hdds: hdds)



# Wait for server to deploy
puts "Creating server..."
puts server.wait_for



# Add a new IP to the server
puts "Adding an IP to the server..."
response = server.add_ip
```
You may pass in an optional `timeout` value (in minutes) which stops the `wait_for()` method from polling after the given amount of time.  `timeout` is set to 25 minutes by default.  You may also set the `interval` value (in seconds).  The default value for `interval` varies by class.



# <a name="attributes"></a>Class Attributes

When creating a new resource (Server, Image, etc) the class object will automatically parse the returned JSON response and store its unique ID for later use.  This allows you to perform further actions on the resource without having to pass its unique identifier each time.  The ID is stored in the `id` attribute. 

In addition to the `id` attribute, you also have access to the following:
- `first_ip`: the initial IP address assigned to your new server.
- `first_password`: the initial password for connecting to your new server.
- `specs`: hash containing all attributes parsed from JSON response.

`specs` allows you to access any other information from your resource that you might want to use in future operations.  `specs` is updated every time you call `reload()`, and is also continuously updated throughout the duration of `wait_for()`'s execution.

If we extend our previous example, notice how we add a load balancer using the `first_ip` attribute:

```
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API key


# Create a Server
server = OneAndOne::Server.new

hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

response = server.create(name: 'Example App Server',
                         vcore: 1,
                         cores_per_processor: 1,
                         ram: 1,
                         appliance_id: '<IMAGE-ID>',
                         hdds: hdds)



# Wait for server to deploy
puts "Creating server..."
puts server.wait_for



# Create a load balancer
load_balancer = OneAndOne::LoadBalancer.new

rule1 = {
  'protocol' => 'TCP',
  'port_balancer' => 80,
  'port_server' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

response = load_balancer.create(name: 'Test LB',
                                description: 'Example Desc',
                                health_check_test: 'TCP',
                                health_check_interval: 40,
                                persistence: true,
                                persistence_time: 1200,
                                method: 'ROUND_ROBIN',
                                rules: rules)
                                
                                
# Wait for load balancer to deploy
puts "Creating load balancer..."
puts load_balancer.wait_for



# Add the load balancer to the new IP
response = server.add_load_balancer(ip_id: server.first_ip['id'],
                                    load_balancer_id: load_balancer.id)



# Wait for load balancer to be added
puts "Adding load balancer to server IP..."
puts server.wait_for
```



# <a name="servers"></a>Servers

Get started by instantiating a `Server` object:

```
server = OneAndOne::Server.new
```


**List all servers:**

```
response = server.list
```


**Returns a server's current configurations:**

```
response = server.get

OR

response = server.get(server_id: '<SERVER-ID>')
```


**List fixed server options:**

```
response = server.list_fixed
```


**Returns information about a fixed server option:**

```
response = server.get_fixed(fixed_instance_id: '<FIXED-SERVER-ID>')
```


**Returns a server's current hardware configurations:**

```
response = server.hardware

OR

response = server.hardware(server_id: '<SERVER-ID>')
```


**List a server's HDDs:**

```
response = server.hdds

OR

response = server.hdds(server_id: '<SERVER-ID>')
```


**Returns information about a server's HDD:**

```
response = server.get_hdd(hdd_id: '<HDD-ID>')

OR

response = server.get_hdd(server_id: '<SERVER-ID>', hdd_id: '<HDD-ID>')
```


**Returns information about a server's image:**

```
response = server.image

OR

response = server.image(server_id: '<SERVER-ID>')
```


**List a server's IPs:**

```
response = server.ips

OR

response = server.ips(server_id: '<SERVER-ID>')
```


**Returns information about a server's IP:**

```
response = server.ip(ip_id: '<IP-ID>')

OR

response = server.ip(server_id: '<SERVER-ID>', ip_id: '<IP-ID>')
```


**Returns the firewall policy assigned to the server's IP:**

```
response = server.firewall(ip_id: '<IP-ID>')

OR

response = server.firewall(server_id: '<SERVER-ID>', ip_id: '<IP-ID>')
```


**List all load balancers assigned to the server's IP:**

```
response = server.load_balancers(ip_id: '<IP-ID>')

OR

response = server.load_balancers(server_id: '<SERVER-ID>', ip_id: '<IP-ID>')
```


**Returns a server's current state:**

```
response = server.status

OR

response = server.status(server_id: '<SERVER-ID>')
```


**Returns information about the DVD loaded into the virtual DVD unit of a server:**

```
response = server.dvd

OR

response = server.dvd(server_id: '<SERVER-ID>')
```


**List a server's private networks:**

```
response = server.private_networks

OR

response = server.private_networks(server_id: '<SERVER-ID>')
```


**Returns information about a server's private network:**

```
response = server.private_network(private_network_id: '<PRIVATE-NETWORK-ID>')

OR

response = server.private_network(server_id: '<SERVER-ID>', private_network_id: '<PRIVATE-NETWORK-ID>')
```


**Returns information about a server's snapshot:**

```
response = server.snapshot

OR

response = server.snapshot(server_id: '<SERVER-ID>')
```


**Create a fixed server:**

*Note:* `appliance_id` takes an `image_id` string
```

response = server.create(name: 'Example Server',
                         fixed_instance_id: '<FIXED-SERVER-ID>',
                         appliance_id: '<IMAGE-ID>')
```


**Create a custom server:**

*Note:* `hdds` must receive an array with at least one object

*Note:* A Hdd's `size` must be a multiple of `20`

*Note:* `appliance_id` takes an `image_id` string
```
hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

response = server.create(name: 'Example Server',
                         vcore: 1,
                         cores_per_processor: 1,
                         ram: 1,
                         appliance_id: '<IMAGE-ID>',
                         hdds: hdds)
```


**Create a server with SSH Key access:**

*Note:* `hdds` must receive an array with at least one object

*Note:* A Hdd's `size` must be a multiple of `20`

*Note:* `appliance_id` takes an `image_id` string
```
pub_key = '<PUB-KEY>'

hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

response = server.create(name: 'Example Server',
                         vcore: 1,
                         cores_per_processor: 1,
                         ram: 1,
                         appliance_id: '<IMAGE-ID>',
                         hdds: hdds,
                         rsa_key: pub_key)
```


**Create a server with SSH Key access and explicitly declare your datacenter:**

*Note:* `hdds` must receive an array with at least one object

*Note:* A Hdd's `size` must be a multiple of `20`

*Note:* `appliance_id` takes an `image_id` string

*Note:* `appliance_id` location must match datacenter location (ex. DE and DE)
```
pub_key = '<PUB-KEY>'
datacenter = '<DATACENTER-ID>'

hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

response = server.create(name: 'Example Server',
                         vcore: 1,
                         cores_per_processor: 1,
                         ram: 1,
                         appliance_id: '<IMAGE-ID>',
                         hdds: hdds,
                         rsa_key: pub_key,
                         datacenter_id: datacenter)
```


**Add new HDDs to a server:**

*Note:* `hdds` must receive a list with at least one object

*Note:* A Hdd's `size` must be a multiple of `20`
```
hdd2 = {
  'size' => 100,
  'is_main' => false
}

hdds = [hdd2]

response = server.add_hdds(hdds: hdds)

OR

response = server.add_hdds(server_id: '<SERVER-ID>', hdds: hdds)
```


**Add a new IP to the server:**

```
response = server.add_ip

OR

response = server.add_ip(server_id: '<SERVER-ID>')
```


**Add a new load balancer to the server's IP:**

```
response = server.add_load_balancer(ip_id: '<IP-ID>',
                                    load_balancer_id: '<LOAD-BALANCER-ID>')

OR

response = server.add_load_balancer(server_id: '<SERVER-ID>',
                                    ip_id: '<IP-ID>',
                                    load_balancer_id: '<LOAD-BALANCER-ID>')
```


**Assign a private network to the server:**

```
response = server.add_private_network(private_network_id: '<PRIVATE-NETWORK-ID>')

OR

response = server.add_private_network(server_id: '<SERVER-ID>',
                                      private_network_id: '<PRIVATE-NETWORK-ID>')
```


**Create a server snapshot:**

```
response = server.create_snapshot

OR

response = server.create_snapshot(server_id: '<SERVER-ID>')
```


**Clone a server:**

```
response = server.clone(name: 'My Server Clone')

OR

response = server.clone(server_id: '<SERVER-ID>',
                        name: 'My Server Clone')
```


**Modify a server:**

```
response = server.modify(name: 'New Name')

OR

response = server.modify(server_id: '<SERVER-ID>', name: 'New Name')
```


**Modify a server's hardware configurations:**

*Note:* Cannot perform "hot" decreasing of server hardware values.  "Cold" decreasing is allowed.

```
response = server.modify_hardware(ram: 2)

OR

response = server.modify_hardware(server_id: '<SERVER-ID>', ram: 2)
```


**Resize a server's HDD:**

*Note:* `size` must be a multiple of `20`

```
response = server.modify_hdd(hdd_id: '<HDD-ID>',
                             size: 140)

OR

response = server.modify_hdd(server_id: '<SERVER-ID>',
                             hdd_id: '<HDD-ID>',
                             size: 140)
```


**Add a firewall policy to a server's IP:**

```
response = server.add_firewall(ip_id: '<IP-ID>',
                               firewall_id: '<FIREWALL-ID>')

OR

response = server.add_firewall(server_id: '<SERVER-ID>',
                               ip_id: '<IP-ID>',
                               firewall_id: '<FIREWALL-ID>')
```


**Change a server's state:**

*Note:* `action` can be set to `POWER_OFF`, `POWER_ON`, `REBOOT`

*Note:* `method` can be set to `SOFTWARE` or `HARDWARE`

```
response = server.change_status(action: 'REBOOT',
                                method: 'SOFTWARE')

OR

response = server.change_status(server_id: '<SERVER-ID>',
                                action: 'REBOOT',
                                method: 'SOFTWARE')
```


**Load a DVD into the virtual DVD unit of a server:**

```
response = server.load_dvd(dvd_id: '<DVD-ID>')

OR

response = server.load_dvd(server_id: '<SERVER-ID>', dvd_id: '<DVD-ID>')
```


**Restore a snapshot into the server:**

```
response = server.restore_snapshot(snapshot_id: '<SNAPSHOT-ID>')

OR

response = server.restore_snapshot(server_id: '<SERVER-ID>',
                                   snapshot_id: '<SNAPSHOT-ID>')
```


**Install an image onto a server:**

```
response = server.install_image(image_id: '<IMAGE-ID>')

OR

response = server.install_image(server_id: '<SERVER-ID>', image_id: '<IMAGE-ID>')
```


**Delete a server:**

*Note:* Set `keep_ips` to `True` to keep server IPs after deleting a server. (`False` by default)

```
response = server.delete

OR

response = server.delete(server_id: '<SERVER-ID>')
```


**Remove a server's HDD:**

```
response = server.delete_hdd(hdd_id: '<HDD-ID>')

OR

response = server.delete_hdd(server_id: '<SERVER-ID>', hdd_id: '<HDD-ID>')
```


**Release a server's IP and optionally remove it:**

*Note:* Set `keep_ip` to `True` for releasing the IP without deleting it permanently. (`False` by default)

```
response = server.release_ip(ip_id: '<IP-ID>')

OR

response = server.release_ip(server_id: '<SERVER-ID>', ip_id: '<IP-ID>')
```


**Remove a firewall policy from a server's IP:**

```
response = server.remove_firewall(ip_id: '<IP-ID>')

OR

response = server.remove_firewall(server_id: '<SERVER-ID>', ip_id: '<IP-ID>')
```


**Remove a load balancer from a server's IP:**

```
response = server.remove_load_balancer(ip_id: '<IP-ID>',
                                       load_balancer_id: '<LOAD-BALANCER-ID>')

OR

response = server.remove_load_balancer(server_id: '<SERVER-ID>',
                                       ip_id: '<IP-ID>',
                                       load_balancer_id: '<LOAD-BALANCER-ID>')
```


**Remove a server from a private network:**

```
response = server.remove_private_network(private_network_id: '<PRIVATE-NETWORK-ID>')

OR

response = server.remove_private_network(server_id: '<SERVER-ID>',
                                         private_network_id: '<PRIVATE-NETWORK-ID>')
```


**Eject a DVD from the virtual DVD unit of a server:**

```
response = server.eject_dvd

OR

response = server.eject_dvd(server_id: '<SERVER-ID>')
```


**Delete a server's snapshot:**

```
response = server.delete_snapshot(snapshot_id: '<SNAPSHOT-ID>')

OR

response = server.delete_snapshot(server_id: '<SERVER-ID>',
                                  snapshot_id: '<SNAPSHOT-ID>')
```



# <a name="images"></a>Images

Get started by instantiating an `Image` object:

```
image = OneAndOne::Image.new
```



**List all images:**

```
response = image.list
```


**Retrieve a single image:**

```
response = image.get

OR

response = image.get(image_id: '<IMAGE-ID>')
```


**Create an image:**

*Note:* `frequency` can be set to `'ONCE', 'DAILY'`, or `'WEEKLY'`

*Note:* `num_images` must be an integer between `1` and `50`
```
response = image.create(server_id: '<SERVER-ID>',
                        name: 'Example Image',
                        frequency: 'ONCE',
                        num_images: 1)
```


**Modify an image:**

*Note:* `frequency` can only be changed to `'ONCE'`
```
response = image.modify(name: 'New Name')

OR

response = image.modify(image_id: '<IMAGE-ID>', name: 'New Name')
```


**Delete an image:**

```
response = image.delete

OR

response = image.delete(image_id: '<IMAGE-ID>')
```



# <a name="shared-storages"></a>Shared Storages

Get started by instantiating a `SharedStorage` object:

```
shared_storage = OneAndOne::SharedStorage.new
```

**List all shared storages:**

```
response = shared_storage.list
```


**Returns information about a shared storage:**

```
response = shared_storage.get

OR

response = shared_storage.get(shared_storage_id: '<SHARED-STORAGE-ID>')
```


**List a shared storage's servers:**

```
response = shared_storage.servers

OR

response = shared_storage.servers(shared_storage_id: '<SHARED-STORAGE-ID>')
```


**Returns information about a shared storage's server:**

```
response = shared_storage.server(server_id: '<SERVER-ID>')

OR

response = shared_storage.server(shared_storage_id: '<SHARED-STORAGE-ID>',
                                 server_id: '<SERVER-ID>')
```


**List the credentials for accessing shared storages:**

```
response = shared_storage.access
```


**Create a shared storage:**

*Note:* `size` must be a multiple of `50`

```
response = shared_storage.create(name: 'Test SS',
                                 description: 'Example Desc',
                                 size: 200)
```


**Add servers to a shared storage:**

*Note:* `servers` must receive an array with at least one object.

*Note:* `rights` can be set to either `'R'` or `'RW'`. (Read or Read/Write)
```
server1 = {
  'id' => '<SERVER-ID>',
  'rights' => 'RW'
}

servers = [server1]

response = shared_storage.add_servers(servers: servers)

OR

response = shared_storage.add_servers(shared_storage_id: '<SHARED-STORAGE-ID>',
                                      servers: servers)
```


**Modify a shared storage:**

*Note:* `size` must be a multiple of `50`

```
response = shared_storage.modify(name: 'Test SS Rename',
                                 size: 400)

OR

response = shared_storage.modify(shared_storage_id: '<SHARED-STORAGE-ID>',
                                 name: 'Test SS Rename',
                                 size: 400)
```


**Change the password for accessing shared storages:**

```
response = shared_storage.change_password(password: 'newpassword22')
```


**Delete a shared storage:**

```
response = shared_storage.delete

OR

response = shared_storage.delete(shared_storage_id: '<SHARED-STORAGE-ID>')
```


**Remove a server from a shared storage:**

```
response = shared_storage.remove_server(server_id: '<SERVER-ID>')

OR

response = shared_storage.remove_server(shared_storage_id: '<SHARED-STORAGE-ID>',
                                        server_id: '<SERVER-ID>')
```




# <a name="firewall-policies"></a>Firewall Policies


Get started by instantiating a `Firewall` object:

```
firewall = OneAndOne::Firewall.new
```


**List all firewall policies:**

```
response = firewall.list
```


**Retrieve a firewall policy's current specs:**

```
response = firewall.get

OR

response = firewall.get(firewall_id: '<FIREWALL-ID>')
```


**List the IPs assigned to a firewall policy:**

```
response = firewall.ips

OR

response = firewall.ips(firewall_id: '<FIREWALL-ID>')
```


**Retrieve information about an IP assigned to a firewall policy:**

```
response = firewall.ip(ip_id: '<IP-ID>')

OR

response = firewall.ip(firewall_id: '<FIREWALL-ID>', ip_id: '<IP-ID>')
```


**List a firewall policy's rules:**

```
response = firewall.rules

OR

response = firewall.rules(firewall_id: '<FIREWALL-ID>')
```


**Retrieve information about a firewall policy's rule:**

```
response = firewall.rule(rule_id: '<RULE-ID>')

OR

response = firewall.rule(firewall_id: '<FIREWALL-ID>', rule_id: '<RULE-ID>')
```


**Create a firewall policy:**

*Note:* `rules` must receive an array with at least one object.
```
rule1 = {
  'protocol' => 'TCP',
  'port_from' => 80,
  'port_to' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

response = firewall.create(name: 'Test Firewall',
                           description: 'Example Desc',
                           rules: rules)
```


**Add new rules to a firewall policy:**

*Note:* `rules` must receive an array with at least one object.
```
rule2 = {
  'protocol' => 'TCP',
  'port_from' => 90,
  'port_to' => 90,
  'source' => '0.0.0.0'
}

rules = [rule2]

response = firewall.add_rules(rules: rules)

OR

response = firewall.add_rules(firewall_id: '<FIREWALL-ID>', rules: rules)
```


**Add IPs to a firewall policy:**

*Note:* `ips` must receive an array with at least one string.

```
ip1 = '<IP-ID>'

ips = [ip1]

response = firewall.add_ips(ips: ips)

OR

response = firewall.add_ips(firewall_id: '<FIREWALL-ID>', ips: ips)
```


**Modify a firewall policy:**

```
response = firewall.modify(name: 'New Name')

OR

response = firewall.modify(firewall_id: '<FIREWALL-ID>', name: 'New Name')
```


**Delete a firewall policy:**

```
response = firewall.delete

OR

response = firewall.delete(firewall_id: '<FIREWALL-ID>')
```


**Remove a rule from a firewall policy:**

```
response = firewall.remove_rule(rule_id: '<RULE-ID>')

OR

response = firewall.remove_rule(firewall_id: '<FIREWALL-ID>', rule_id: '<RULE-ID>')
```


**Remove a firewall policy's IP:**

```
response = firewall.remove_ip(ip_id: '<IP-ID>')

OR

response = firewall.remove_ip(firewall_id: '<FIREWALL-ID>', ip_id: '<IP-ID>')
```




# <a name="load-balancers"></a>Load Balancers

Get started by instantiating a `LoadBalancer` object:

```
load_balancer = OneAndOne::LoadBalancer.new
```


**List all load balancers:**

```
response = load_balancer.list
```


**Returns the current specs of a load balancer:**

```
response = load_balancer.get

OR

response = load_balancer.get(load_balancer_id: '<LOAD-BALANCER-ID>')
```


**List the IP's assigned to a load balancer:**

```
response = load_balancer.ips

OR

response = load_balancer.ips(load_balancer_id: '<LOAD-BALANCER-ID>')
```


**Returns information about an IP assigned to the load balancer:**

```
response = load_balancer.ip(ip_id: '<IP-ID>')

OR

response = load_balancer.ip(load_balancer_id: '<LOAD-BALANCER-ID>',
                            ip_id: '<IP-ID>')
```


**List all load balancer rules:**

```
response = load_balancer.rules

OR

response = load_balancer.rules(load_balancer_id: '<LOAD-BALANCER-ID>')
```


**Returns information about a load balancer's rule:**

```
response = load_balancer.rule(rule_id: '<RULE-ID>')

OR

response = load_balancer.rule(load_balancer_id: '<LOAD-BALANCER-ID>',
                              rule_id: '<RULE-ID>')
```


**Create a load balancer:**

*Note:* `health_check_test` can only be set to `'TCP'` at the moment

*Note:* `health_check_interval` can range from `5` to `300` seconds

*Note:* `persistence_time` is required if `persistence` is enabled, and can range from `30` to `1200` seconds

*Note:* `method` can be set to `'ROUND_ROBIN'` or `'LEAST_CONNECTIONS'`

*Note:* `rules` must receive an array with at least one object
```
rule1 = {
  'protocol' => 'TCP',
  'port_balancer' => 80,
  'port_server' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

response = load_balancer.create(name: 'Test LB',
                                description: 'Example Desc',
                                health_check_test: 'TCP',
                                health_check_interval: 40,
                                persistence: true,
                                persistence_time: 1200,
                                method: 'ROUND_ROBIN',
                                rules: rules)
```


**Add a load balancer to IP's:**

*Note:* `ips` must receive an array with at least one IP string
```
ip1 = '<IP-ID>'

ips = [ip1]

response = load_balancer.add_ips(ips: ips)

OR

response = load_balancer.add_ips(load_balancer_id: '<LOAD-BALANCER-ID>',
                                 ips: ips)
```


**Add new rules to a load balancer:**

*Note:* `rules` must receive an array with at least one object
```
rule2 = {
  'protocol' => 'TCP',
  'port_balancer' => 90,
  'port_server' => 90,
  'source' => '0.0.0.0'
}

rules = [rule2]

response = load_balancer.add_rules(rules: rules)

OR

response = load_balancer.add_rules(load_balancer_id: '<LOAD-BALANCER-ID>',
                                   rules: rules)
```


**Modify a load balancer:**

```
response = load_balancer.modify(name: 'New Name')

OR

response = load_balancer.modify(load_balancer_id: '<LOAD-BALANCER-ID>',
                                name: 'New Name')
```


**Delete a load balancer:**

```
response = load_balancer.delete

OR

response = load_balancer.delete(load_balancer_id: '<LOAD-BALANCER-ID>')
```


**Remove a load balancer from an IP:**

```
response = load_balancer.remove_ip(ip_id: '<IP-ID>')

OR

response = load_balancer.remove_ip(load_balancer_id: '<LOAD-BALANCER-ID>',
                                   ip_id: '<IP-ID>')
```


**Remove a load balancer's rule:**

```
response = load_balancer.remove_rule(rule_id: '<RULE-ID>')

OR

response = load_balancer.remove_rule(load_balancer_id: '<LOAD-BALANCER-ID>',
                                     rule_id: '<RULE-ID>')
```



# <a name="public-ips"></a>Public IPs


Get started by instantiating a `PublicIP` object:

```
public_ip = OneAndOne::PublicIP.new
```

**List all public IPs on your account:**

```
response = public_ip.list
```


**Returns a public IP's current specs:**

```
response = public_ip.get

OR

response = public_ip.get(ip_id: '<IP-ID>')
```


**Create a public IP:**

*Note:* `reverse_dns` is an optional parameter

```
response = public_ip.create(reverse_dns: 'example.com')
```


**Modify a public IP:**

*Note:* If you call this method without a `reverse_dns` argument, it will remove the previous `reverse_dns` value

```
response = public_ip.modify(reverse_dns: 'newexample.com')

OR

response = public_ip.modify(ip_id: '<IP-ID>', reverse_dns: 'newexample.com')
```


**Delete a public IP:**

```
response = public_ip.delete

OR

response = public_ip.delete(ip_id: '<IP-ID>')
```




# <a name="private-networks"></a>Private Networks


Get started by instantiating a `PrivateNetwork` object:

```
private_network = OneAndOne::PrivateNetwork.new
```

**List all private networks:**

```
response = private_network.list
```


**Returns a private network's current specs:**

```
response = private_network.get

OR

response = private_network.get(private_network_id: '<PRIVATE-NETWORK-ID>')
```


**List a private network's servers:**

```
response = private_network.servers

OR

response = private_network.servers(private_network_id: '<PRIVATE-NETWORK-ID>')
```


**Returns information about a private network's server:**

```
response = private_network.server(server_id: '<SERVER-ID>')

OR

response = private_network.server(private_network_id: '<PRIVATE-NETWORK-ID>',
                                  server_id: '<SERVER-ID>')
```


**Create a private network:**

*Note:* `name` is the only required parameter
```
response = private_network.create(name: 'Test PN',
                                  network_address: '192.168.1.0',
                                  subnet_mask: '255.255.255.0')
```


**Add servers to a private network:**

*Note:* `servers` must receive an array with at least one server ID string

*Note:* Servers cannot be added or removed from a private network if they currently have a snapshot.
```
server1 = '<SERVER-ID>'

servers = [server1]

response = private_network.add_servers(servers: servers)

OR

response = private_network.add_servers(private_network_id: '<PRIVATE-NETWORK-ID>',
                                       servers: servers)
```


**Modify a private network:**

```
response = private_network.modify(name: 'New PN Name')

OR

response = private_network.modify(private_network_id: '<PRIVATE-NETWORK-ID>',
                                  name: 'New PN Name')
```


**Delete a private network:**

```
response = private_network.delete

OR

response = private_network.delete(private_network_id: '<PRIVATE-NETWORK-ID>')
```


**Remove a server from a private network:**

*Note:* Servers cannot be attached or removed from a private network if they currently have a snapshot.

*Note:* Servers cannot be removed from a private network when they are 'online'.

```
response = private_network.remove_server(server_id: '<SERVER-ID>')

OR

response = private_network.remove_server(private_network_id: '<PRIVATE-NETWORK-ID>',
                                         server_id: '<SERVER-ID>')
```




# <a name="monitoring-center"></a>Monitoring Center


Get started by instantiating a `MonitoringCenter` object:

```
monitoring_center = OneAndOne::MonitoringCenter.new
```

**List all usages and alerts of monitoring servers:**

```
response = monitoring_center.list
```


**Retrieve the usages and alerts for a monitoring server:**

*Note:* `period` can be set to `'LAST_HOUR'`, `'LAST_24H'`, `'LAST_7D'`, `'LAST_30D'`, `'LAST_365D'`, or `'CUSTOM'`

*Note:* If `period` is set to `'CUSTOM'`, the `start_date` and `end_date` parameters are required.  They should be
set using the following date/time format: `2015-19-05T00:05:00Z`

```
response = monitoring_center.get(server_id: '<SERVER-ID>', period: 'LAST_24H')
```




# <a name="monitoring-policies"></a>Monitoring Policies


Get started by instantiating a `MonitoringPolicy` object:

```
monitoring_policy = OneAndOne::MonitoringPolicy.new
```

**List all monitoring policies:**

```
response = monitoring_policy.list
```


**Returns a monitoring policy's current specs:**

```
response = monitoring_policy.get

OR

response = monitoring_policy.get(monitoring_policy_id: '<MONITORING-POLICY-ID>')
```


**List a monitoring policy's ports:**

```
response = monitoring_policy.ports

OR

response = monitoring_policy.ports(monitoring_policy_id: '<MONITORING-POLICY-ID>')
```


**Returns information about a monitoring policy's port:**

```
response = monitoring_policy.port(port_id: '<PORT-ID>')

OR

response = monitoring_policy.port(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                  port_id: '<PORT-ID>')
```


**List a monitoring policy's processes:**

```
response = monitoring_policy.processes

OR

response = monitoring_policy.processes(monitoring_policy_id: '<MONITORING-POLICY-ID>')
```


**Returns information about a monitoring policy's process:**

```
response = monitoring_policy.process(process_id: '<PROCESS-ID>')

OR

response = monitoring_policy.process(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                     process_id: '<PROCESS-ID>')
```


**List a monitoring policy's servers:**

```
response = monitoring_policy.servers

OR

response = monitoring_policy.servers(monitoring_policy_id: '<MONITORING-POLICY-ID>')
```


**Returns information about a monitoring policy's server:**

```
response = monitoring_policy.server(server_id: '<SERVER-ID>')

OR

response = monitoring_policy.server(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                    server_id: '<SERVER-ID>')
```


**Create a monitoring policy:**

*Note:* `thresholds` must receive a hash with the exact keys/values shown below.  Only the `value` and `alert` keys may be changed

*Note:* `ports` must receive an array with at least one object

*Note:* `processes` must receive an array with at least one object
```
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
                                    email: 'test@example.com',
                                    agent: true,
                                    thresholds: thresholds,
                                    ports: ports,
                                    processes: processes)
```


**Add ports to a monitoring policy:**

*Note:* `ports` must receive an array with at least one object
```
port2 = {
  'protocol' => 'TCP',
  'port' => 90,
  'alert_if' => 'NOT_RESPONDING',
  'email_notification' => true
}

ports = [port2]

response = monitoring_policy.add_ports(ports: ports)

OR

response = monitoring_policy.add_ports(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                       ports: ports)
```


**Add processes to a monitoring policy:**

*Note:* `processes` must receive an array with at least one object
```
process2 = {
  'process' => 'logger',
  'alert_if' => 'NOT_RUNNING',
  'email_notification' => true
}

processes = [process2]

response = monitoring_policy.add_processes(processes: processes)

OR

response = monitoring_policy.add_processes(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                           processes: processes)
```


**Add servers to a monitoring policy:**

*Note:* `servers` must receive an array with at least one server ID string
```
server1 = '<SERVER-ID>'

servers = [server1]

response = monitoring_policy.add_servers(servers: servers)

OR

response = monitoring_policy.add_servers(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                         servers: servers)
```

**Modify a monitoring policy:**

*Note:* `thresholds` is not a required parameter, but it must receive a "thresholds hash" exactly like the one in the `monitoring_policy.create()` method above, if you do choose to update.
```
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

response = monitoring_policy.modify(name: 'New Name',
                                    thresholds: new_thresholds)

OR

response = monitoring_policy.modify(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                    name: 'New Name',
                                    thresholds: new_thresholds)
```


**Modify a monitoring policy's port:**

*Note:* Only `alert_if` and `email_notification` can be updated.  `protocol` and `port` are immutable.  You will still need to send in the entire "port hash", as you would when creating a monitoring policy, or adding new ports to an existing monitoring policy
```
port1 = {
  'protocol' => 'TCP',
  'port' => 80,
  'alert_if' => 'RESPONDING',
  'email_notification' => false
}

response = monitoring_policy.modify_port(port_id: '<PORT-ID>',
                                         new_port: port1)

OR

response = monitoring_policy.modify_port(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                         port_id: '<PORT-ID>',
                                         new_port: port1)
```


**Modify a monitoring policy's process:**

*Note:* Only `alert_if` and `email_notification` can be updated.  `process` is immutable.  You will still need to send in the entire "process hash", as you would when creating a monitoring policy or adding new processes to an existing monitoring policy
```
process1 = {
  'process' => 'test',
  'alert_if' => 'RUNNING',
  'email_notification' => false
}

response = monitoring_policy.modify_process(process_id: '<PROCESS-ID>',
                                            new_process: process1)

OR

response = monitoring_policy.modify_process(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                            process_id: '<PROCESS-ID>',
                                            new_process: process1)
```


**Delete a monitoring policy:**

```
response = monitoring_policy.delete

OR

response = monitoring_policy.delete(monitoring_policy_id: '<MONITORING-POLICY-ID>')
```


**Delete a monitoring policy's port:**

```
response = monitoring_policy.delete_port(port_id: '<PORT-ID>')

OR

response = monitoring_policy.delete_port(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                         port_id: '<PORT-ID>')
```


**Delete a monitoring policy's process:**

```
response = monitoring_policy.delete_process(process_id: '<PROCESS-ID>')

OR

response = monitoring_policy.delete_process(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                            process_id: '<PROCESS-ID>')
```


**Remove a monitoring policy's server:**

```
response = monitoring_policy.remove_server(server_id: '<SERVER-ID>')

OR

response = monitoring_policy.remove_server(monitoring_policy_id: '<MONITORING-POLICY-ID>',
                                           server_id: '<SERVER-ID>')
```





# <a name="logs"></a>Logs


Get started by instantiating a `Log` object:

```
log = OneAndOne::Log.new
```

**List all logs by time period:**

*Note:* `period` can be set to `'LAST_HOUR'`, `'LAST_24H'`, `'LAST_7D'`, `'LAST_30D'`, `'LAST_365D'`, or `'CUSTOM'`

*Note:* If `period` is set to `'CUSTOM'`, the `start_date` and `end_date` parameters are required.  They should be
set using the following date/time format: `2015-19-05T00:05:00Z`

```
response = log.list(period: 'LAST_24H')
```


**Returns information about a log:**

```
response = log.get(log_id: '<LOG-ID>')
```



# <a name="users"></a>Users


Get started by instantiating a `User` object:

```
user = OneAndOne::User.new
```

**List all users on your account:**

```
response = user.list
```


**Return a user's current specs:**

```
response = user.get

OR

response = user.get(user_id: '<USER-ID>')
```


**Return a user's API access credentials:**

```
response = user.api

OR

response = user.api(user_id: '<USER-ID>')
```


**Return a user's API key:**

```
response = user.api_key

OR

response = user.api_key(user_id: '<USER-ID>')
```


**List the IP's from which a user can access the API:**

```
response = user.ips

OR

response = user.ips(user_id: '<USER-ID>')
```


**Create a user:**

```
response = user.create(name: 'TestUser',
                       email: 'test@example.com',
                       password: 'testpass')
```


**Add IP's from which a user can access the API:**

*Note:* `ips` must receive an array with at least one IP string
```
ip1 = '1.2.3.4'

ips = [ip1]

response = user.add_ips(ips: ips)

OR

response = user.add_ips(user_id: '<USER-ID>', ips: ips)
```


**Modify a user:**

*Note:* `state` can be set to `ACTIVE` or `DISABLE`

```
response = user.modify(description: 'New Description',
                       email: 'newemail@example.com',
                       state: 'ACTIVE')

OR

response = user.modify(user_id: '<USER-ID>',
                       description: 'New Description',
                       email: 'newemail@example.com',
                       state: 'ACTIVE')
```


**Enable or disable a user's API access:**

```
response = user.enable_api(active: true)

OR

response = user.enable_api(user_id: '<USER-ID>', active: true)
```


**Change a user's API key:**

```
response = user.change_key

OR

response = user.change_key(user_id: '<USER-ID>')
```


**Delete a user:**

```
response = user.delete

OR

response = user.delete(user_id: '<USER-ID>')
```


**Remove API access for an IP:**

```
ip1 = '1.2.3.4'

response = user.remove_ip(ip: ip1)

OR

response = user.remove_ip(user_id: '<USER-ID>',
                          ip: ip1)
```




# <a name="usages"></a>Usages


Get started by instantiating a `Usage` object:

```
usage = OneAndOne::Usage.new
```

**List all usages by time period:**

*Note:* `period` can be set to `'LAST_HOUR'`, `'LAST_24H'`, `'LAST_7D'`, `'LAST_30D'`, `'LAST_365D'`, or `'CUSTOM'`

*Note:* If `period` is set to `'CUSTOM'`, the `start_date` and `end_date` parameters are required.  They should be
set using the following date/time format: `2015-19-05T00:05:00Z`

```
response = usage.list(period: 'LAST_24H')
```



# <a name="server-appliances"></a>Server Appliances


Get started by instantiating a `ServerAppliance` object:

```
appliance = OneAndOne::ServerAppliance.new
```

**List all appliances:**

```
response = appliance.list
```


**Returns information about an appliance:**

```
response = appliance.get(appliance_id: '<APPLIANCE-ID>')
```



# <a name="dvds"></a>DVD's


Get started by instantiating a `Dvd` object:

```
dvd = OneAndOne::Dvd.new
```

**List all DVD's on your account:**

```
response = dvd.list
```


**Returns information about a DVD:**

```
response = dvd.get(dvd_id: '<DVD-ID>')
```



# <a name="datacenters"></a>Data Centers


Get started by instantiating a `Datacenter` object:

```
datacenter = OneAndOne::Datacenter.new
```

**List all available data centers:**

```
response = datacenter.list
```


**Returns information about a data center:**

```
response = datacenter.get(datacenter_id: '<DATACENTER-ID>')
```



# <a name="pricing"></a>Pricing


Get started by instantiating a `Pricing` object:

```
pricing = OneAndOne::Pricing.new
```

**List pricing for all available resources in Cloud Panel:**

```
response = pricing.list
```



# <a name="ping"></a>Ping


Get started by instantiating a `Ping` object:

```
ping = OneAndOne::Ping.new
```

**Returns `"PONG"` if the API is running:**

```
response = ping.get
```



# <a name="ping-auth"></a>Ping Auth


Get started by instantiating a `PingAuth` object:

```
ping_auth = OneAndOne::PingAuth.new
```

**Returns `"PONG"` if the API is running and your token is valid:**

```
response = ping_auth.get
```



# <a name="vpn"></a>VPN's

Get started by instantiating an `Vpn` object:

```
vpn = OneAndOne::Vpn.new
```



**List all VPN's:**

```
response = vpn.list
```


**Retrieve a single VPN:**

```
response = vpn.get

OR

response = vpn.get(vpn_id: '<VPN-ID>')
```


**Create a VPN:**

```
response = vpn.create(name: 'Example VPN')
```


**Modify a VPN:**

```
response = vpn.modify(name: 'New Name')

OR

response = vpn.modify(vpn_id: '<VPN-ID>', name: 'New Name')
```


**Delete a VPN:**

```
response = vpn.delete

OR

response = vpn.delete(vpn_id: '<VPN-ID>')
```


**Download a VPN's config file:**

```
response = vpn.download_config

OR

response = vpn.download_config(vpn_id: '<VPN-ID>')
```



# <a name="roles"></a>Roles

Get started by instantiating an `Role` object:

```
role = OneAndOne::Role.new
```



**List all available roles on your account:**

```
response = role.list
```


**Retrieve a single role:**

```
response = role.get

OR

response = role.get(role_id: '<ROLE-ID>')
```


**Create a role:**

```
response = role.create(name: 'Example Role')
```


**Modify a role:**

```
response = role.modify(name: 'New Name', state: 'ACTIVE')

OR

response = role.modify(role_id: '<ROLE-ID>', name: 'New Name', state: 'ACTIVE')
```


**Delete a role:**

```
response = role.delete

OR

response = role.delete(role_id: '<ROLE-ID>')
```



**List a role's permissions:**

```
response = role.permissions

OR

response = role.permissions(role_id: '<ROLE-ID>')
```



**Modify a role's permissions:**

```
server_perms = {
  'show' => true,
  'create' => true,
  'delete' => false
}

response = role.modify_permissions(servers: server_perms)

OR

response = role.modify_permissions(role_id: '<ROLE-ID>', servers: server_perms)
```



**List the users assigned to a role:**

```
response = role.users

OR

response = role.users(role_id: '<ROLE-ID>')
```



**Assign new users to a role:**

```
users = ['<USER1-ID>', '<USER2-ID>']

response = role.add_users(users: users)

OR

response = role.add_users(role_id: '<ROLE-ID>', users: users)
```



**Returns information about a user assigned to a role:**

```
response = role.get_user(user_id: '<USER-ID>')

OR

response = role.get_user(role_id: '<ROLE-ID>', user_id: '<USER-ID>')
```



**Unassign a user from a role:**

```
response = role.remove_user(user_id: '<USER-ID>')

OR

response = role.remove_user(role_id: '<ROLE-ID>', user_id: '<USER-ID>')
```



**Clone a role:**

```
response = role.clone(name: 'Role Clone')

OR

response = role.clone(role_id: '<ROLE-ID>', name: 'Role Clone')
```



# <a name="ssh-keys"></a>SSH Keys

Get started by instantiating an `SshKey` object:

```
ssh_key = OneAndOne::SshKey.new
```



**List all available ssh keys on your account:**

```
response = ssh_key.list
```


**Retrieve a single ssh key:**

```
response = ssh_key.get

OR

response = ssh_key.get(ssh_key_id: '<SSH-KEY-ID>')
```


**Create an ssh key:**

```
response = ssh_key.create(name: 'Test SSH Key',
                          description: 'Test Description',
                          public_key: '<PUBLIC-KEY>')
```


**Modify an ssh key:**

```
response = ssh_key.modify(name: 'New Name', description: 'New Description')

OR

response = ssh_key.modify(ssh_key_id: '<SSH-KEY-ID>', name: 'New Name', description: 'New Description')
```


**Delete an ssh key:**

```
response = ssh_key.delete

OR

response = ssh_key.delete(ssh_key_id: '<SSH-KEY-ID>')
```