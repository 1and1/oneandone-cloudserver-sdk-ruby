Shared Storages
*****************

.. rb:class:: OneAndOne::SharedStorage()
   
   The :rb:class:`SharedStorage` class allows a user to perform actions against the 1and1 API.


   .. rb:method:: list(page: nil, per_page: nil, sort: nil, q: nil, fields: nil)

     Return a list of all shared storages.

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


   .. rb:method:: create(name: nil, description: nil, size: nil)

     Create a shared storage.

     :param name: shared storage name.
     :type name:  ``str``

     :param description: shared storage description.
     :type description: ``str``

     :param size: shared storage size.
     :type size: ``int``

     :rtype: JSON


   .. rb:method:: get(shared_storage_id: @id)

     Returns a shared storage's current specs.

     :param shared_storage_id: the unique identifier for the shared storage.
     :type shared_storage_id: ``str``

     :rtype: JSON


   .. rb:method:: modify(shared_storage_id: @id, name: nil, description: nil, size: nil)

     Modify a shared storage.

     :param shared_storage_id: the unique identifier for the shared storage.
     :type shared_storage_id: ``str``

     :param name: shared storage name.
     :type name: ``str``

     :param description: shared storage description.
     :type description: ``str``

     :param size: shared storage size.  Must be a multiple of ``50``.
     :type size: ``int``

     :rtype: JSON


   .. rb:method:: delete(shared_storage_id: @id)

     Delete a shared storage.

     :param shared_storage_id: the unique identifier for the shared storage.
     :type shared_storage_id: ``str``

     :rtype: JSON


   .. rb:method:: add_servers(shared_storage_id: @id, servers: nil)

     Add servers to a shared storage.

     :param shared_storage_id: the unique identifier for the shared storage.
     :type shared_storage_id: ``str``

     :param servers: an array of server hashes.
     :type servers: ``array``

     :rtype: JSON


   .. rb:method:: servers(shared_storage_id: @id)

     List a shared storage's servers.

     :param shared_storage_id: the unique identifier for the shared storage.
     :type shared_storage_id: ``str``

     :rtype: JSON


   .. rb:method:: server(shared_storage_id: @id, server_id: nil)

     Returns information about a shared storage's server.

     :param shared_storage_id: the unique identifier for the shared storage.
     :type shared_storage_id: ``str``

     :param server_id: the unique identifier for the server.
     :type server_id: ``str``

     :rtype: JSON


   .. rb:method:: remove_server(shared_storage_id: @id, server_id: nil)

     Remove a server from a shared storage.

     :param shared_storage_id: the unique identifier for the shared storage.
     :type shared_storage_id: ``str``

     :param server_id: the unique identifier for the server.
     :type server_id: ``str``

     :rtype: JSON


   .. rb:method:: access()

     Retrieve the credentials for accessing shared storages.

     :rtype: JSON


   .. rb:method:: change_password(password: nil)

     Change the password for accessing shared storages.

     :param password: new shared storage password.
     :type password: ``str``

     :rtype: JSON


   .. rb:method:: wait_for()

     Polls the shared storage until an "ACTIVE" state is returned.  Use this when chaining actions.

     :rtype: ``nil``