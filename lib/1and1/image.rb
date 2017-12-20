module OneAndOne

  
  class Image

    
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
      path = OneAndOne.build_url('/images')

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


    def get(image_id: @id)

      # If user passed in image ID, reassign
      @id = image_id

      # Build URL
      path = OneAndOne.build_url("/images/#{@id}")

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


    def create(server_id: nil, name: nil, description: nil, frequency: nil,
      num_images: nil, source: nil, url: nil, os_id: nil, type: nil)

      # Build POST body
      new_image = {
        'server_id' => server_id,
        'name' => name,
        'description' => description,
        'frequency' => frequency,
        'num_images' => num_images,
        'source' => source,
        'url' => url,
        'os_id' => os_id,
        'type' => type
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_image)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url('/images')

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Save new image ID to Image instance
      @id = json['id']
      @specs = json

      # If all good, return JSON
      json

    end


    def modify(image_id: @id, name: nil, description: nil, frequency: nil)

      # If user passed in image ID, reassign
      @id = image_id

      # Build PUT body
      image_specs = {
        'name' => name,
        'description' => description,
        'frequency' => frequency
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(image_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/images/#{@id}")

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


    def delete(image_id: @id)

      # If user passed in image ID, reassign
      @id = image_id

      # Build URL
      path = OneAndOne.build_url("/images/#{@id}")

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


    def wait_for(timeout: 25, interval: 15)

      # Capture start time
      start = Time.now

      # Poll image and check initial state
      initial_response = get
      image_state = initial_response['state']

      # Keep polling the image's state until good
      until $good_states.include? image_state

        # Wait 15 seconds before polling again
        sleep interval

        # Check image state again
        current_response = get
        image_state = current_response['state']

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