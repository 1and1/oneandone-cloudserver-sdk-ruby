Servers
********

.. rb:class:: OneAndOne::Server()
   
   The :rb:class:`Server` class allows a user to perform actions against the 1and1 API.

   
    .. rb:method:: list(page: nil, per_page: nil, sort: nil, q: nil, fields: nil)

      Return a list of all images.

      :param page: Allows the use of pagination. Indicate which page to start on.
      :type page: ``int``

      :param per_page: Number of items per page.
      :type per_page: ``int``

      :param sort: ``sort: 'name'`` retrieves a list of elements sorted 
        alphabetically. ``sort: 'creation_date'`` retrieves a list of elements 
        sorted by their creation date in descending order.
      :type sort: ``str``

      :param q: ``q`` is for query. Use this parameter to return only the items 
        that match your search query.
      :type q: ``str``

      :param fields: Returns only the parameters requested. 
        (i.e. fields: 'id, name, description, hardware.ram')
      :type fields: ``str``

      :rtype: JSON



    .. rb:method:: create(name: nil, description: nil, fixed_instance_id: nil, vcore: nil, cores_per_processor: nil, ram: nil, appliance_id: nil, hdds: nil, password: nil, power_on: nil, firewall_id: nil, ip_id: nil, load_balancer_id: nil, monitoring_policy_id: nil)

      Create a server.

      .. note:: Only the following parameters are **required** to create a server:
            
         * ``name``
         * ``description``
         * ``vcore``
         * ``cores_per_processor``
         * ``ram``
         * ``appliance_id``

      .. note:: Your HDD's size must be a multiple of ``20``.

      :param name: server name.
      :type name: ``str``

      :param description: server description.
      :type description: ``str``

      :param fixed_instance_id: the unique identifier for your desired fixed server flavor.
      :type fixed_instance_id: ``str``

      :param vcore: Total amount of virtual cores.
      :type vcore: ``int``

      :param cores_per_processor: Number of cores per processor.
      :type cores_per_processor: ``int``

      :param ram: Memory size.
      :type ram: ``int``

      :param appliance_id: image to be installed on the server.
      :type appliance_id: ``str``

      :param hdds: takes an array of HDD's.
      :type hdds: ``array``

      :param password: server password.
      :type password: ``str``

      :param power_on: choose whether or not you want the server to 'POWER_ON' after creation.  (True by default)
      :type power_on: ``bool``

      :param firewall_id: the unique identifier for the firewall policy to be assigned.
      :type firewall_id: ``str``

      :param ip_id: the unique identifier for the IP to be assigned.
      :type ip_id: ``str``

      :param load_balancer_id: the unique identifier for the load balancer to be assigned.
      :type load_balancer_id: ``str``

      :param monitoring_policy_id: the unique identifier for the monitoring policy to be assigned.
      :type monitoring_policy_id: ``str``

      :rtype: JSON



    .. rb:method:: list_fixed()

       Returns a list of available fixed server options.

       :rtype: JSON



    .. rb:method:: get_fixed(fixed_instance_id: nil)

       Retrieve information about a fixed server option.

       :param fixed_instance_id: the unique identifier for the fixed server option.
       :type fixed_instance_id: ``str``

       :rtype: JSON



    .. rb:method:: get(server_id: @id)

       Retrieve the current specs of a server.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :rtype: JSON



    .. rb:method:: modify(server_id: @id, name: nil, description: nil)

       Modify a server.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param name: server name.
       :type name: ``str``

       :param description: server description.
       :type description: ``str``

       :rtype: JSON



    .. rb:method:: delete(server_id: @id, keep_ips: nil)

       Delete a server.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param keep_ips: Set ``keep_ips`` to ``True`` to keep server IPs after deleting a server. (``False`` by default).
       :type keep_ips: ``bool``

       :rtype: JSON



    .. rb:method:: hardware(server_id: @id)

       Retrieve a server's hardware configurations.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :rtype: JSON



    .. rb:method:: modify_hardware(server_id: @id, fixed_instance_id: nil, vcore: nil, cores_per_processor: nil, ram: nil)

       Modify a server's hardware.

       .. note:: Cannot perform "hot" decreasing of server hardware values. "Cold" decreasing is allowed.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param fixed_instance_id: ID of the instance size for the server. It 
             is not possible to resize to a fixed instance with a HDD smaller than the current one.
       :type fixed_instance_size_id: ``str``

       :param vcore: Total amount of virtual cores.
       :type vcore: ``int``

       :param cores_per_processor: Number of cores per processor.
       :type cores_per_processor: ``int``

       :param ram: Memory size.
       :type ram: ``int``

       :rtype: JSON



    .. rb:method:: hdds(server_id: @id)

       Returns a list of the server's HDD's.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :rtype: JSON



    .. rb:method:: add_hdds(server_id: @id, hdds: nil)

       Add additional HDD's to a server.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param hdds: takes an array of HDD's.
       :type hdds: ``array``

       :rtype: JSON



    .. rb:method:: get_hdd(server_id: @id, hdd_id: nil)

       Retrieve information about a server's HDD.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param hdd_id: the unique identifier for the HDD.
       :type hdd_id: ``str``

       :rtype: JSON



    .. rb:method:: modify_hdd(server_id: @id, hdd_id: nil, size: nil)

       Modify a server's HDD.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param hdd_id: the unique identifier for the server's HDD.
       :type hdd_id: ``str``

       :param size: the new size of the HDD.  Must be a multiple of ``20``.
       :type size: ``int``

       :rtype: JSON



    .. rb:method:: delete_hdd(server_id: @id, hdd_id: nil)

       Delete a server's HDD.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param hdd_id: the unique identifier for the server's HDD.
       :type hdd_id: ``str``

       :rtype: JSON



    .. rb:method:: image(server_id: @id)

       Returns information about a server's image.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :rtype: JSON



    .. rb:method:: install_image(server_id: @id, image_id: nil, password: nil, firewall_id: nil)

       Installs an image onto the server.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param image_id: the unique identifier for the server image.
       :type image_id: ``str``

       :param password: server password.
       :type password: ``str``

       :param firewall_id: the unique identifier for the firewall policy to be assigned.
       :type firewall_id: ``str``

       :rtype: JSON



    .. rb:method:: ips(server_id: @id)

       Returns a list of the server's IP's.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :rtype: JSON



    .. rb:method:: add_ip(server_id: @id, ip_type: nil)

       Add an IP to the server.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param ip_type: at the moment, only ```IPV4``` is currently supported.
       :type ip_type: ``str``

       :rtype: JSON



    .. rb:method:: ip(server_id: @id, ip_id: nil)

       Returns information about a server's IP.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param ip_id: the unique identifier for the IP.
       :type ip_id: ``str``

       :rtype: JSON



    .. rb:method:: release_ip(server_id: @id, ip_id: nil, keep_ip: nil)

       Release an IP from the server.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param ip_id: the unique identifier for the server's IP.
       :type ip_id: ``str``

       :param keep_ip: Set ``keep_ip`` to ``True`` for releasing the IP without deleting it permanently. (``False`` by default)
       :type keep_ip: ``bool``

       :rtype: JSON



    .. rb:method:: add_firewall(server_id: @id, ip_id: nil, firewall_id: nil)

       Add a firewall policy to a server's IP.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param ip_id: the unique identifier for the server's IP.
       :type ip_id: ``str``

       :param firewall_id: the unique identifier for the firewall policy.
       :type firewall_id: ``str``

       :rtype: JSON



    .. rb:method:: firewall(server_id: @id, ip_id: nil)

       Returns information about a server IP's firewall policy.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param ip_id: the unique identifier for the server's IP.
       :type ip_id: ``str``

       :rtype: JSON



    .. rb:method:: remove_firewall(server_id: @id, ip_id: nil)

       Remove a firewall policy from a server's IP.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param ip_id: the unique identifier for the server's IP.
       :type ip_id: ``str``

       :rtype: JSON



    .. rb:method:: load_balancers(server_id: @id, ip_id: nil)

       Returns a list of the load balancers assigned to a server IP.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param ip_id: the unique identifier for the server's IP.
       :type ip_id: ``str``

       :rtype: JSON



    .. rb:method:: add_load_balancer(server_id: @id, ip_id: nil, load_balancer_id: nil)

       Add a load balancer to a server's IP.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param ip_id: the unique identifier for the server's IP.
       :type ip_id: ``str``

       :param load_balancer_id: the unique identifier for the load balancer. 
       :type load_balancer_id: ``str``

       :rtype: JSON



    .. rb:method:: remove_load_balancer(server_id: @id, ip_id: nil, load_balancer_id: nil)

       Remove a load balancer from a server's IP.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param ip_id: the unique identifier for the server's IP.
       :type ip_id: ``str``

       :param load_balancer_id: the unique identifier for the load balancer. 
       :type load_balancer_id: ``str``

       :rtype: JSON



    .. rb:method:: status(server_id: @id)

       Retrieve the server's current state.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :rtype: JSON



    .. rb:method:: change_status(server_id: @id, action: nil, method: nil)

       Modify a server's state.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param action: the action to perform on the server.  Possible values are ``'POWER_OFF'``, ``'POWER_ON'``,  and ``'REBOOT'``.
       :type action: ``str``

       :param method: the action's method.  Possible values are ``'SOFTWARE'`` or ``'HARDWARE'``.
       :type method: ``str``

       :rtype: JSON



    .. rb:method:: dvd(server_id: @id)

       Returns information about the DVD currently loaded into the server.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :rtype: JSON



    .. rb:method:: load_dvd(server_id: @id, dvd_id: nil)

       Loads a DVD into the server.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param dvd_id: the unique identifier for the DVD.
       :type dvd_id: ``str``

       :rtype: JSON



    .. rb:method:: eject_dvd(server_id: @id)

       Eject the DVD from the server.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :rtype: JSON



    .. rb:method:: private_networks(server_id: @id)

       Returns a list of the server's private networks.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :rtype: JSON



    .. rb:method:: private_network(server_id: @id, private_network_id: nil)

       Returns information about a server's private network.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param private_network_id: the unique identifier for the private network.
       :type private_network_id: ``str``

       :rtype: JSON



    .. rb:method:: remove_private_network(server_id: @id, private_network_id: nil)

       Removes a server from a private network.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param private_network_id: the unique identifier for the private network.
       :type private_network_id: ``str``

       :rtype: JSON



    .. rb:method:: add_private_network(server_id: @id, private_network_id: nil)

       Add a server to a private network.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param private_network_id: the unique identifier for the private network.
       :type private_network_id: ``str``

       :rtype: JSON



    .. rb:method:: create_snapshot(server_id: @id)

       Creates a server snapshot.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :rtype: JSON



    .. rb:method:: snapshot(server_id: @id)

       Returns information about a server's snapshot.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :rtype: JSON



    .. rb:method:: restore_snapshot(server_id: @id, snapshot_id: nil)

       Restore a server's snapshot.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param snapshot_id: the unique identifier for the server snapshot.
       :type snapshot_id: ``str``

       :rtype: JSON



    .. rb:method:: delete_snapshot(server_id: @id, snapshot_id: nil)

       Remove a server's snapshot.

       :param server_id: the unique identifier for the server.
       :type server_id: ``str``

       :param snapshot_id: the unique identifier for the server snapshot.
       :type snapshot_id: ``str``

       :rtype: JSON



    .. rb:method:: clone(server_id: @id, name: nil)

       Clone a server.

       :param server_id: the unique identifier for the server to be cloned.
       :type server_id: ``str``

       :param name: the new server's name.
       :type name: ``str``

       :rtype: JSON



    .. rb:method:: wait_for()

       Polls the server until an "ACTIVE", "POWERED_ON", or "POWERED_OFF" state is returned.  Use this when chaining actions.

       :rtype: ``nil``