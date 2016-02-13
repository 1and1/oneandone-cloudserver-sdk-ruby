Firewall Policies
*****************

.. rb:class:: OneAndOne::Firewall()
   
   The :rb:class:`Firewall` class allows a user to perform actions against the 1and1 API.


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


   .. rb:method:: create(name: nil, description: nil, rules: nil)

     Create a firewall policy.

     :param name: firewall policy's name.
     :type name: ``str``

     :param description: firewall policy's name.
     :type description: ``str``

     :param rules: an array of rules for the new firewall policy.
     :type rules: ``array``

     :rtype: JSON


   .. rb:method:: get(firewall_id: @id)

     Returns a firewall policy's current specs.

     :param firewall_id: the unique identifier for the firewall.
     :type firewall_id: ``str``

     :rtype: JSON


   .. rb:method:: modify(firewall_id: @id, name: nil, description: nil)

     Modify a firewall policy.

     :param firewall_id: the unique identifier for the firewall policy.
     :type firewall_id: ``str``

     :param name: firewall policy name.
     :type name: ``str``

     :param description: firewall policy description.
     :type description: ``str``

     :rtype: JSON


   .. rb:method:: delete(firewall_id: @id)

     Delete a firewall policy.

     :param firewall_id: the unique identifier for the firewall.
     :type firewall_id: ``str``

     :rtype: JSON


   .. rb:method:: ips(firewall_id: @id)

     Returns a list of the IPs assigned to a firewall policy.

     :param firewall_id: the unique identifier for the firewall.
     :type firewall_id: ``str``

     :rtype: JSON


   .. rb:method:: ip(firewall_id: @id, ip_id: nil)

     Returns information about an IP assigned to a firewall policy.

     :param firewall_id: the unique identifier for the firewall policy.
     :type firewall_id: ``str``

     :param ip_id: the unique identifier for the IP.
     :type ip_id: ``str``

     :rtype: JSON


   .. rb:method:: add_ips(firewall_id: @id, ips: nil)

     Add IPs to a firewall policy.

     :param firewall_id: the unique identifier for the firewall policy.
     :type firewall_id: ``str``

     :param ips: an array of IP ID's for the new firewall policy..
     :type ips: ``array``

     :rtype: JSON


   .. rb:method:: remove_ip(firewall_id: @id, ip_id: nil)

     Remove an IP from a firewall policy.

     :param firewall_id: the unique identifier for the firewall policy.
     :type firewall_id: ``str``

     :param ip_id: the unique identifier for the IP.
     :type ip_id: ``str``

     :rtype: JSON


   .. rb:method:: rules(firewall_id: @id)

     Returns a list the firewall policy's rules.

     :param firewall_id: the unique identifier for the firewall.
     :type firewall_id: ``str``

     :rtype: JSON


   .. rb:method:: rule(firewall_id: @id, rule_id: nil)

     Returns information about a firewall policy's rule.

     :param firewall_id: the unique identifier for the firewall policy.
     :type firewall_id: ``str``

     :param rule_id: the unique identifier for the firewall rule.
     :type rule_id: ``str``

     :rtype: JSON


   .. rb:method:: add_rules(firewall_id: @id, rules: nil)

     Add rules to a firewall policy.

     :param firewall_id: the unique identifier for the firewall policy.
     :type firewall_id: ``str``

     :param rules: an array of rule objects.
     :type rules: ``array``

     :rtype: JSON


   .. rb:method:: remove_rule(firewall_id: @id, rule_id: nil)

     Remove a firewall policy's rule.

     :param firewall_id: the unique identifier for the firewall policy.
     :type firewall_id: ``str``

     :param rule_id: the unique identifier for the firewall rule.
     :type rule_id: ``str``

     :rtype: JSON


   .. rb:method:: wait_for()

     Polls the firewall policy until an "ACTIVE" state is returned.  Use this when chaining actions.

     :rtype: ``nil``