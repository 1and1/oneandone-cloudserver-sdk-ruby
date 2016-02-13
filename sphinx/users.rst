Users
*****************

.. rb:class:: OneAndOne::User()
   
   The :rb:class:`User` class allows a user to perform actions against the 1and1 API.


   .. rb:method:: list(page: nil, per_page: nil, sort: nil, q: nil, fields: nil)

     List all users on your account.

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


   .. rb:method:: create(name: nil, description: nil, password: nil, email: nil)

     Create a new user account.

     :param name: user name.
     :type name: ``str``

     :param description: user description.
     :type description: ``str``

     :param password: user password.
     :type password: ``str``

     :param email: user email.
     :type email: ``str``

     :rtype: JSON


   .. rb:method:: get(user_id: @id)

     Returns a user account's current specs.

     :param user_id: the unique identifier for the user.
     :type user_id: ``str``

     :rtype: JSON


   .. rb:method:: modify(user_id: @id, description: nil, password: nil, email: nil, state: nil)

     Modify a user account.

     :param user_id: the unique identifier for the user.
     :type user_id: ``str``

     :param password: user password.
     :type password: ``str``

     :param email: user email.
     :type email: ``str``

     :param description: user description.
     :type description: ``str``

     :param state: allows you to enable and disable users.  Possible values are ``"ACTIVE"`` or ``"DISABLE"``.
     :type state: ``str``

     :rtype: JSON


   .. rb:method:: delete(user_id: @id)

     Delete a user account.

     :param user_id: the unique identifier for the user.
     :type user_id: ``str``

     :rtype: JSON


   .. rb:method:: api(user_id: @id)

     Return a user's API access credentials.

     :param user_id: the unique identifier for the user.
     :type user_id: ``str``

     :rtype: JSON


   .. rb:method:: enable_api(user_id: @id, active: nil)

     Enable or disable a user's API access.

     :param user_id: the unique identifier for the user.
     :type user_id: ``str``

     :param active: API access.
     :type active: ``bool``

     :rtype: JSON


   .. rb:method:: api_key(user_id: @id)

     Return a user's API key.

     :param user_id: the unique identifier for the user.
     :type user_id: ``str``

     :rtype: JSON


   .. rb:method:: change_key(user_id: @id)

     Change a user's API key.

     :param user_id: the unique identifier for the user.
     :type user_id: ``str``

     :rtype: JSON


   .. rb:method:: ips(user_id: @id)

     List the IP's from which a user can access the API.

     :param user_id: the unique identifier for the user.
     :type user_id: ``str``

     :rtype: JSON


   .. rb:method:: add_ips(user_id: @id, ips: nil)

     Add IP's from which a user can access the API.

     :param user_id: the unique identifier for the user.
     :type user_id: ``str``

     :param ips: an array containing at least one IP string.
     :type ips: ``array``

     :rtype: JSON


   .. rb:method:: remove_ip(user_id: @id, ip: nil)

     Remove API access for an IP.

     :param user_id: the unique identifier for the user.
     :type user_id: ``str``

     :param ip: IP to be removed.
     :type ip: ``str``

     :rtype: JSON