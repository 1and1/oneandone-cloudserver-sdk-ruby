module OneAndOne


  class MonitoringPolicy

    
    attr_accessor :id
    attr_accessor :specs


    def initialize(test: false)
      @id = nil
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
      path = OneAndOne.build_url('/monitoring_policies')

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


    def create(name: nil, description: nil, email: nil, agent: nil,
      thresholds: nil, ports: nil, processes: nil)

      # Build POST body
      new_monitoring_policy = {
        'name' => name,
        'description' => description,
        'email' => email,
        'agent' => agent,
        'thresholds' => thresholds,
        'ports' => ports,
        'processes' => processes
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_monitoring_policy)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url('/monitoring_policies')

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Save new monitoring policy ID to MonitoringPolicy instance
      @id = json['id']
      @specs = json

      # If all good, return JSON
      json

    end


    def get(monitoring_policy_id: @id)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}")

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


    def modify(monitoring_policy_id: @id, name: nil, description: nil,
      email: nil, thresholds: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build PUT body
      modified_mp = {
        'name' => name,
        'description' => description,
        'email' => email,
        'thresholds' => thresholds
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(modified_mp)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}")

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


    def delete(monitoring_policy_id: @id)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def ports(monitoring_policy_id: @id)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/ports")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_ports(monitoring_policy_id: @id, ports: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build POST body
      new_ports = {
        'ports' => ports
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_ports)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/ports")

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


    def port(monitoring_policy_id: @id, port_id: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/ports/#{port_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def modify_port(monitoring_policy_id: @id, port_id: nil, new_port: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build PUT body
      modified_port = {
        'ports' => new_port
      }

      # Stringify the POST body
      string_body = modified_port.to_json

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/ports/#{port_id}")

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


    def delete_port(monitoring_policy_id: @id, port_id: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/ports/#{port_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def processes(monitoring_policy_id: @id)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/processes")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def process(monitoring_policy_id: @id, process_id: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/processes/#{process_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_processes(monitoring_policy_id: @id, processes: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build POST body
      new_processes = {
        'processes' => processes
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_processes)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/processes")

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


    def modify_process(monitoring_policy_id: @id, process_id: nil,
      new_process: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build PUT body
      modified_process = {
        'processes' => new_process
      }

      # Stringify the POST body
      string_body = modified_process.to_json

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/processes/#{process_id}")

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


    def delete_process(monitoring_policy_id: @id, process_id: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/processes/#{process_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def servers(monitoring_policy_id: @id)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/servers")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def server(monitoring_policy_id: @id, server_id: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/servers/#{server_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_servers(monitoring_policy_id: @id, servers: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build POST body
      new_servers = {
        'servers' => servers
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_servers)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/servers")

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


    def remove_server(monitoring_policy_id: @id, server_id: nil)

      # If user passed in monitoring policy ID, reassign
      @id = monitoring_policy_id

      # Build URL
      path = OneAndOne.build_url("/monitoring_policies/#{@id}/servers/#{server_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def reload

      # This reload fx is just a wrapper for the get fx
      get

    end


    def wait_for(timeout: 25, interval: 1)

      # Capture start time
      start = Time.now

      # Poll MP and check initial state
      initial_response = get
      mp_state = initial_response['state']

      # Keep polling the MP's state until good
      until $good_states.include? mp_state

        # Wait 1 second before polling again
        sleep interval

        # Check MP state again
        current_response = get
        mp_state = current_response['state']

        # Calculate current duration and check for timeout
        duration = (Time.now - start) / 60
        if duration > timeout
          puts "The operation timed out after #{timeout} minutes.\n"
          return
        end

      end

      # Return Duration
      {:duration => duration}

    end


  end


end