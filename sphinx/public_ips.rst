Public IPs
*****************

.. rb:class:: OneAndOne::PublicIP()
   
   The :rb:class:`PublicIP` class allows a user to perform actions against the 1and1 API.


   .. rb:method:: list(page: nil, per_page: nil, sort: nil, q: nil, fields: nil)

     Return a list of all public IPs.

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


   .. rb:method:: create(reverse_dns: nil, type: nil)

     Create a public IP.

     :param reverse_dns: reverse dns name.
     :type reverse_dns: ``str``

     :param type: can only be set to ``'IPV4'`` at this time.
     :type type: ``str``

     :rtype: JSON


   .. rb:method:: get(ip_id: @id)

     Returns a public IP's current specs.

     :param ip_id: the unique identifier for the IP.
     :type ip_id: ``str``

     :rtype: JSON


   .. rb:method:: modify(ip_id: @id, reverse_dns: nil)

     Modify a public IP.

     :param ip_id: the unique identifier for the IP.
     :type ip_id: ``str``

     :param reverse_dns: reverse dns name.
     :type reverse_dns: ``str``

     :rtype: JSON


   .. rb:method:: delete(ip_id: @id)

     Delete a public IP.

     :param ip_id: the unique identifier for the IP.
     :type ip_id: ``str``

     :rtype: JSON