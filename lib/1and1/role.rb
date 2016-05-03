module OneAndOne


  class Role

    
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
      path = OneAndOne.build_url('/roles')

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


    def create(name: nil)

      # Build POST body
      new_role = {
        'name' => name
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_role)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url('/roles')

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Save new role ID to Role instance
      @id = json['id']
      @specs = json

      # If all good, return JSON
      json

    end


    def get(role_id: @id)

      # If user passed in role ID, reassign
      @id = role_id

      # Build URL
      path = OneAndOne.build_url("/roles/#{@id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def modify(role_id: @id, name: nil, description: nil, state: nil)

      # If user passed in role ID, reassign
      @id = role_id

      # Build PUT body
      new_role = {
        'name' => name,
        'description' => description,
        'state' => state
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(new_role)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/roles/#{@id}")

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


    def delete(role_id: @id)

      # If user passed in role ID, reassign
      @id = role_id

      # Build URL
      path = OneAndOne.build_url("/roles/#{@id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def permissions(role_id: @id)

      # If user passed in role ID, reassign
      @id = role_id

      # Build URL
      path = OneAndOne.build_url("/roles/#{@id}/permissions")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def modify_permissions(role_id: @id, servers: nil, images: nil,
      shared_storages: nil, firewalls: nil, load_balancers: nil, ips: nil,
      private_networks: nil, vpns: nil, monitoring_centers: nil,
      monitoring_policies: nil, backups: nil, logs: nil, users: nil,
      roles: nil, usages: nil, interactive_invoices: nil)

      # If user passed in role ID, reassign
      @id = role_id

      # Build PUT body
      new_perms = {
        'servers' => servers,
        'images' => images,
        'sharedstorages' => shared_storages,
        'firewalls' => firewalls,
        'loadbalancers' => load_balancers,
        'ips' => ips,
        'privatenetwork' => private_networks,
        'vpn' => vpns,
        'monitoringcenter' => monitoring_centers,
        'monitoringpolicies' => monitoring_policies,
        'backups' => backups,
        'logs' => logs,
        'users' => users,
        'roles' => roles,
        'usages' => usages,
        'interactiveinvoice' => interactive_invoices
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(new_perms)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/roles/#{@id}/permissions")

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


    def users(role_id: @id)

      # If user passed in role ID, reassign
      @id = role_id

      # Build URL
      path = OneAndOne.build_url("/roles/#{@id}/users")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_users(role_id: @id, users: nil)

      # If user passed in role ID, reassign
      @id = role_id

      # Create POST body
      new_users = {
        'users' => users
      }

      # Stringify the POST body
      string_body = new_users.to_json

      # Build URL
      path = OneAndOne.build_url("/roles/#{@id}/users")

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


    def get_user(role_id: @id, user_id: nil)

      # If user passed in role ID, reassign
      @id = role_id

      # Build URL
      path = OneAndOne.build_url("/roles/#{@id}/users/#{user_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def remove_user(role_id: @id, user_id: nil)

      # If user passed in role ID, reassign
      @id = role_id

      # Build URL
      path = OneAndOne.build_url("/roles/#{@id}/users/#{user_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def clone(role_id: @id, name: nil)

      # If user passed in role ID, reassign
      @id = role_id

      # Build POST body
      new_role = {
        'name' => name
      }

      # Stringify the POST body
      string_body = new_role.to_json

      # Build URL
      path = OneAndOne.build_url("/roles/#{@id}/clone")

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


  end


end