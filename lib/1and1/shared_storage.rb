module OneAndOne


  class SharedStorage

    
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
      path = OneAndOne.build_url('/shared_storages')

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


    def create(name: nil, description: nil, size: nil, datacenter_id: nil)

      # Build POST body
      new_storage = {
        'name' => name,
        'description' => description,
        'size' => size,
        'datacenter_id' => datacenter_id
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_storage)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url('/shared_storages')

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Save new shared storage ID to SharedStorage instance
      @id = json['id']
      @specs = json

      # If all good, return JSON
      json

    end


    def get(shared_storage_id: @id)

      # If user passed in shared_storage ID, reassign
      @id = shared_storage_id

      # Build URL
      path = OneAndOne.build_url("/shared_storages/#{@id}")

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


    def modify(shared_storage_id: @id, name: nil, description: nil, size: nil)

      # If user passed in shared_storage ID, reassign
      @id = shared_storage_id

      # Build PUT body
      new_storage = {
        'name' => name,
        'description' => description,
        'size' => size,
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_storage)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/shared_storages/#{@id}")

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


    def delete(shared_storage_id: @id)

      # If user passed in shared_storage ID, reassign
      @id = shared_storage_id

      # Build URL
      path = OneAndOne.build_url("/shared_storages/#{@id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_servers(shared_storage_id: @id, servers: nil)

      # If user passed in shared_storage ID, reassign
      @id = shared_storage_id

      # Build POST body
      new_servers = {
        'servers' => servers
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_servers)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/shared_storages/#{@id}/servers")

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


    def servers(shared_storage_id: @id)

      # If user passed in shared_storage ID, reassign
      @id = shared_storage_id

      # Build URL
      path = OneAndOne.build_url("/shared_storages/#{@id}/servers")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def server(shared_storage_id: @id, server_id: nil)

      # If user passed in shared_storage ID, reassign
      @id = shared_storage_id

      # Build URL
      path = OneAndOne.build_url("/shared_storages/#{@id}/servers/#{server_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def remove_server(shared_storage_id: @id, server_id: nil)

      # If user passed in shared_storage ID, reassign
      @id = shared_storage_id

      # Build URL
      path = OneAndOne.build_url("/shared_storages/#{@id}/servers/#{server_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def access

      # Build URL
      path = OneAndOne.build_url('/shared_storages/access')

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def change_password(password: nil)

      # Build PUT body
      new_password = {
        'password' => password
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(new_password)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url('/shared_storages/access')

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


    def reload

      # This reload fx is just a wrapper for the get fx
      get

    end


    def wait_for(timeout: 25, interval: 5)

      # Capture start time
      start = Time.now

      # Poll shared storage and check initial state
      initial_response = get
      shared_storage_state = initial_response['state']

      # Keep polling the shared storage's state until good
      until $good_states.include? shared_storage_state

        # Wait 5 seconds before polling again
        sleep interval

        # Check shared storage state again
        current_response = get
        shared_storage_state = current_response['state']

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