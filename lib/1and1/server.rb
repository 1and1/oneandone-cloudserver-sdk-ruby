module OneAndOne


  class Server

    
    attr_accessor :id
    attr_accessor :first_ip
    attr_accessor :first_password
    attr_accessor :specs


    def initialize(test: false)
      @id = nil
      @first_ip = nil
      @first_password = nil
      @specs = nil

      # Check if hitting mock api or live api
      if test
        @connection = Excon.new($base_url, :mock => true)
      else
        @connection = Excon.new($base_url)
      end

    end


    def list(page: nil, per_page: nil, sort: nil, q: nil, fields: nil)

      # Build hash for query parameters
      keyword_args = {
        :page => page,
        :per_page => per_page,
        :sort => sort,
        :q => q,
        :fields => fields
      }

      # Clean out null query parameters
      params = OneAndOne.clean_hash(keyword_args)

      # Build URL
      path = OneAndOne.build_url('/servers')

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header,
        :query => params)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def create(name: nil, description: nil, rsa_key: nil, fixed_instance_id: nil,
      vcore: nil, cores_per_processor: nil, ram: nil, appliance_id: nil,
      datacenter_id: nil, hdds: nil, password: nil, power_on: nil,
      firewall_id: nil, ip_id: nil, load_balancer_id: nil,
      monitoring_policy_id: nil)

      # Build hardware hash
      hardware_params = {
        'fixed_instance_size_id' => fixed_instance_id,
        'vcore' => vcore,
        'cores_per_processor' => cores_per_processor,
        'ram' => ram,
        'hdds' => hdds
      }

      # Clean out null keys in hardware hash
      hardware = OneAndOne.clean_hash(hardware_params)

      # Build POST body
      new_server = {
        'name' => name,
        'description' => description,
        'hardware' => hardware,
        'appliance_id' => appliance_id,
        'datacenter_id' => datacenter_id,
        'rsa_key' => rsa_key,
        'password' => password,
        'power_on' => power_on,
        'firewall_policy_id' => firewall_id,
        'ip_id' => ip_id,
        'load_balancer_id' => load_balancer_id,
        'monitoring_policy_id' => monitoring_policy_id
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_server)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url('/servers')

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Save new server ID to Server instance
      @specs = json
      @id = json['id']
      @first_password = json['first_password']

      # If all good, return JSON
      json

    end


    def list_fixed

      # Build URL
      path = OneAndOne.build_url('/servers/fixed_instance_sizes')

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def get_fixed(fixed_instance_id: nil)

      # Build URL
      path = OneAndOne.build_url("/servers/fixed_instance_sizes/#{fixed_instance_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def get(server_id: @id)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Reload specs attribute
      @specs = json

      # If all good, return JSON
      json

    end


    def modify(server_id: @id, name: nil, description: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      server_specs = {
        'name' => name,
        'description' => description
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(server_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}")

      # Perform Request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def delete(server_id: @id, keep_ips: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build hash for query parameters
      keyword_args = {
        'keep_ips' => keep_ips
      }

      # Clean out null query parameters
      params = OneAndOne.clean_hash(keyword_args)

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header,
        :query => params)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def hardware(server_id: @id)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/hardware")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def modify_hardware(server_id: @id, fixed_instance_id: nil, vcore: nil,
      cores_per_processor: nil, ram: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      hardware_specs = {
        'fixed_instance_size_id' => fixed_instance_id,
        'vcore' => vcore,
        'cores_per_processor' => cores_per_processor,
        'ram' => ram
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(hardware_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/hardware")

      # Perform Request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def hdds(server_id: @id)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/hardware/hdds")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_hdds(server_id: @id, hdds: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build POST body
      new_hdds = {
        'hdds' => hdds
      }

      # Stringify the POST body
      string_body = new_hdds.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/hardware/hdds")

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def get_hdd(server_id: @id, hdd_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/hardware/hdds/#{hdd_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def modify_hdd(server_id: @id, hdd_id: nil, size: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      hdd_specs = {
        'size' => size
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(hdd_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/hardware/hdds/#{hdd_id}")

      # Perform Request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def delete_hdd(server_id: @id, hdd_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/hardware/hdds/#{hdd_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def image(server_id: @id)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/image")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def install_image(server_id: @id, image_id: nil, password: nil,
      firewall_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      image_specs = {
        'id' => image_id,
        'password' => password,
        'firewall_policy' => {
          'id' => firewall_id
        }
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(image_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/image")

      # Perform Request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def ips(server_id: @id)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/ips")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_ip(server_id: @id, ip_type: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      ip_specs = {
        'type' => ip_type
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(ip_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/ips")

      # Perform Request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def ip(server_id: @id, ip_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/ips/#{ip_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end

    def release_ip(server_id: @id, ip_id: nil, keep_ip: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      ip_specs = {
        'keep_ip' => keep_ip
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(ip_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/ips/#{ip_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_firewall(server_id: @id, ip_id: nil, firewall_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      firewall_specs = {
        'id' => firewall_id
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(firewall_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/ips/#{ip_id}/firewall_policy")

      # Perform request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def firewall(server_id: @id, ip_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/ips/#{ip_id}/firewall_policy")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def remove_firewall(server_id: @id, ip_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/ips/#{ip_id}/firewall_policy")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def load_balancers(server_id: @id, ip_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/ips/#{ip_id}/load_balancers")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_load_balancer(server_id: @id, ip_id: nil, load_balancer_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      load_balancer_specs = {
        'load_balancer_id' => load_balancer_id
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(load_balancer_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/ips/#{ip_id}/load_balancers")

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def remove_load_balancer(server_id: @id, ip_id: nil, load_balancer_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/ips/#{ip_id}/load_balancers/#{load_balancer_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def status(server_id: @id)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/status")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def change_status(server_id: @id, action: nil, method: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      status_specs = {
        'action' => action,
        'method' => method
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(status_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/status/action")

      # Perform request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def dvd(server_id: @id)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/dvd")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def load_dvd(server_id: @id, dvd_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      dvd_specs = {
        'id' => dvd_id
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(dvd_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/dvd")

      # Perform request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def eject_dvd(server_id: @id)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/dvd")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def private_networks(server_id: @id)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/private_networks")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def private_network(server_id: @id, private_network_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/private_networks/#{private_network_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def remove_private_network(server_id: @id, private_network_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/private_networks/#{private_network_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_private_network(server_id: @id, private_network_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      private_network_specs = {
        'id' => private_network_id
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(private_network_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/private_networks")

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def create_snapshot(server_id: @id)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/snapshots")

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def snapshot(server_id: @id)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/snapshots")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def restore_snapshot(server_id: @id, snapshot_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/snapshots/#{snapshot_id}")

      # Perform request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def delete_snapshot(server_id: @id, snapshot_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/snapshots/#{snapshot_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def clone(server_id: @id, name: nil, datacenter_id: nil)

      # If user passed in server ID, reassign
      @id = server_id

      # Build PUT body
      clone_specs = {
        'name' => name,
        'datacenter_id' => datacenter_id
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(clone_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/servers/#{@id}/clone")

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def reload

      # This reload fx is just a wrapper for the get fx
      get

    end


    def check_state(response)

      # Parse out server state and percent from response
      state = response['status']['state']
      percent = response['status']['percent']

      # This is the ideal server state we are looking for
      ($good_states.include? state) && (percent == nil)

    end


    def parser(response)

      # Check for first IP
      ips = response['ips']

      if ips.length == 1
        @first_ip = ips[0]
      end

    end


    def wait_for(timeout: 25, interval: 15)

      # Capture start time
      start = Time.now

      # Poll server and check initial state
      initial_response = get
      server_state = check_state(initial_response)

      # Keep polling the server's state until good
      until server_state

        # Wait 15 seconds before polling again
        sleep interval

        # Check server state and percent again
        current_response = get
        server_state = check_state(current_response)

        # Calculate current duration and check for timeout
        duration = (Time.now - start) / 60
        if duration > timeout
          puts "The operation timed out after #{timeout} minutes.\n"
          return
        end

        # Parse for first IP
        parser(current_response)

      end

      # Return Duration
      {:duration => duration}

    end


  end


end