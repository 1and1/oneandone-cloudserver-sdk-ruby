module OneAndOne


  def OneAndOne.start(api_token)
    
    # Set core values to be used across the module
    $api_token = api_token
    $base_url = 'https://cloudpanel-api.1and1.com'
    $version = '/v1'
    $header = {
      'X-TOKEN' => $api_token,
      'Content-Type' => 'application/json'
    }
    $success_codes = [200, 201, 202]
    $good_states = ['ACTIVE', 'POWERED_ON', 'POWERED_OFF']

  end


  def OneAndOne.clean_hash(hash)

    hash.each do |key, value|
      if value == nil
        hash.delete(key)
      end
    end

  end


  def OneAndOne.build_url(endpoint)

    path = $version + endpoint

  end


  def OneAndOne.check_response(message, status)
    
    # Check for server error
    if status == 500
      raise "Internal Server Error.  Please try again."
    end

    # Raise exception if a bad status code is received
    if not $success_codes.include? status
      raise message
    end

  end


end