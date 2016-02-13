Private Networks
*****************

.. rb:class:: OneAndOne::PrivateNetwork()
   
   The :rb:class:`PrivateNetwork` class allows a user to perform actions against the 1and1 API.


   .. rb:method:: list(page: nil, per_page: nil, sort: nil, q: nil, fields: nil)

     Return a list of all private networks.

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


   .. rb:method:: create(name: nil, description: nil, network_address: nil, subnet_mask: nil)

     Create a private network.

     :param name: private network name.
     :type name: ``str``

     :param description: private network description.
     :type description: ``str``

     :param network_address: Private network address. (valid IP)
     :type network_address: ``str``

     :param subnet_mask: Subnet mask (valid subnet for the given IP).
     :type subnet_mask: ``str``

     :rtype: JSON


   .. rb:method:: get(private_network_id: @id)

     Returns a private network's current specs.

     :param private_network_id: the unique identifier for the private network.
     :type private_network_id: ``str``

     :rtype: JSON


   .. rb:method:: modify(private_network_id: @id, name: nil, description: nil, network_address: nil, subnet_mask: nil)

     Modify a private network.

     :param name: private network name.
     :type name: ``str``

     :param description: private network description.
     :type description: ``str``

     :param network_address: Private network address. (valid IP)
     :type network_address: ``str``

     :param subnet_mask: Subnet mask (valid subnet for the given IP).
     :type subnet_mask: ``str``

     :rtype: JSON


   .. rb:method:: delete(private_network_id: @id)

     Delete a private network.

     :param private_network_id: the unique identifier for the private network.
     :type private_network_id: ``str``

     :rtype: JSON


   .. rb:method:: servers(private_network_id: @id)

     Lists a private network's servers.

     :param private_network_id: the unique identifier for the private network.
     :type private_network_id: ``str``

     :rtype: JSON


   .. rb:method:: server(private_network_id: @id, server_id: nil)

     Returns information about a private network's server.

     :param private_network_id: the unique identifier for the private network.
     :type private_network_id: ``str``

     :param server_id: the unique identifier for the server.
     :type server_id: ``str``

     :rtype: JSON


   .. rb:method:: remove_server(private_network_id: @id, server_id: nil)

     Remove a server from a private network.

     :param private_network_id: the unique identifier for the private network.
     :type private_network_id: ``str``

     :param server_id: the unique identifier for the server.
     :type server_id: ``str``

     :rtype: JSON


   .. rb:method:: add_servers(private_network_id: @id, servers: nil)

     Add servers to a private network.

     :param private_network_id: the unique identifier for the private network.
     :type private_network_id: ``str``

     :param servers: an array of server ID strings.
     :type servers: ``array``

     :rtype: JSON


   .. rb:method:: wait_for()

     Polls the private network until an "ACTIVE" state is returned.  Use this when chaining actions.

     :rtype: ``nil``