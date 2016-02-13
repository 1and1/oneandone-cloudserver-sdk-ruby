Load Balancers
*****************

.. rb:class:: OneAndOne::LoadBalancer()
   
   The :rb:class:`LoadBalancer` class allows a user to perform actions against the 1and1 API.


   .. rb:method:: list(page: nil, per_page: nil, sort: nil, q: nil, fields: nil)

     Return a list of all load balancers.

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


   .. rb:method:: create(name: nil, description: nil, health_check_test: nil, health_check_interval: nil, persistence: nil, persistence_time: nil, method: nil, rules: nil, health_check_path: nil, health_check_parse: nil)

     Create a load balancer.

     :param name: load balancer name.
     :type name: ``str``

     :param description: load balancer description.
     :type description: ``str``

     :param health_check_test: possible values are ``"NONE"`` or ``"TCP"``.
     :type health_check_test: ``str``

     :param health_check_interval: Health check period in seconds.  Can range between ``5`` and ``300`` seconds.
     :type health_check_interval: ``int``

     :param persistence: enable or disable persistence.
     :type persistence: ``bool``

     :param persistence_time: Persistence time in seconds. Required if persistence is enabled.  Can range from ``30`` to ``1200`` seconds
     :type persistence_time: ``int``

     :param method: balancing procedure.  Possible values are ``"ROUND_ROBIN"`` or ``"LEAST_CONNECTIONS"``.
     :type method: ``str`` 

     :param rules: takes an array of "rule" objects to be added to the load balancer.
     :type rules: ``array``

     :param health_check_path: Url to call for checking. Required for HTTP health check.
     :type health_check_path: ``str``

     :param health_check_parse: Regular expression to check. Required for HTTP health check.
     :type health_check_parse: ``str``


   .. rb:method:: get(load_balancer_id: @id)

     Returns the current specs of a load balancer.

     :param load_balancer_id: the unique identifier for the load balancer.
     :type load_balancer_id: ``str``

     :rtype: JSON


   .. rb:method:: modify(load_balancer_id: @id, name: nil, description: nil, health_check_test: nil, health_check_interval: nil, persistence: nil, persistence_time: nil, method: nil, health_check_path: nil, health_check_parse: nil)

      Modify a load balancer.

      :param load_balancer_id: the unique identifier for the load balancer.
      :type load_balancer_id: ``str``

      :param name: load balancer name.
      :type name: ``str``

      :param description: load balancer description.
      :type description: ``str``

      :param health_check_test: possible values are ``"NONE"``,``"TCP"``, or ``"HTTP"``.
      :type health_check_test: ``str``

      :param health_check_interval: Health check period in seconds.
      :type health_check_interval: ``int``

      :param persistence: enable or disable persistnece.
      :type persistence: ``bool``

      :param persistence_time: Persistence time in seconds. Required if persistence is enabled.
      :type persistence_time: ``int``

      :param method: balancing procedure.  possible values are ``"ROUND_ROBIN"`` or ``"LEAST_CONNECTIONS"``.
      :type method: ``str``

      :param health_check_path: Url to call for checking. Required for HTTP health check.
      :type health_check_path: ``str``

      :param health_check_parse: Regular expression to check. Required for HTTP health check.
      :type health_check_parse: ``str``

      :rtype: JSON


   .. rb:method:: delete(load_balancer_id: @id)

     Delete a load balancer.

     :param load_balancer_id: the unique identifier for the load balancer.
     :type load_balancer_id: ``str``

     :rtype: JSON


   .. rb:method:: ips(load_balancer_id: @id)

     Returns a list of the IP's assigned to a load balancer.

     Delete a load balancer.

     :param load_balancer_id: the unique identifier for the load balancer.
     :type load_balancer_id: ``str``

     :rtype: JSON


   .. rb:method:: ip(load_balancer_id: @id, ip_id: nil)

     Returns information about an IP assigned to a load balancer.

     :param load_balancer_id: the unique identifier for the load balancer.
     :type load_balancer_id: ``str``

     :param ip_id: the unique identifier for the IP.
     :type ip_id: ``str``

     :rtype: JSON


   .. rb:method:: remove_ip(load_balancer_id: @id, ip_id: nil)

     Remove an IP from a load balancer.

     :param load_balancer_id: the unique identifier for the load balancer.
     :type load_balancer_id: ``str``

     :param ip_id: the unique identifier for the IP.
     :type ip_id: ``str``

     :rtype: JSON


   .. rb:method:: add_ips(load_balancer_id: @id, ips: nil)

     Assign IP's to a load balancer.

     :param load_balancer_id: the unique identifier for the load balancer.
     :type load_balancer_id: ``str``

     :param ips: takes an array of IP strings to be added to the load balancer.
     :type ips: ``array``

     :rtype: JSON


   .. rb:method:: rules(load_balancer_id: @id)

     Returns a list of the load balancer's rules.

     :param load_balancer_id: the unique identifier for the load balancer.
     :type load_balancer_id: ``str``

     :rtype: JSON


   .. rb:method:: rule(load_balancer_id: @id, rule_id: nil)

     Returns information about a load balancer's rule.

     :param load_balancer_id: the unique identifier for the load balancer.
     :type load_balancer_id: ``str``

     :param rule_id: the unique identifier for the rule.
     :type rule_id: ``str``

     :rtype: JSON


   .. rb:method:: add_rules(load_balancer_id: @id, rules: nil)

     Add rules to a load balancer.

     :param load_balancer_id: the unique identifier for the load balancer.
     :type load_balancer_id: ``str``

     :param rules: takes an array of "rule" objects to be added to the load balancer.
     :type rules: ``array``

     :rtype: JSON


   .. rb:method:: remove_rule(load_balancer_id: @id, rule_id: nil)

     Remove a load balancer's rule.

     :param load_balancer_id: the unique identifier for the load balancer.
     :type load_balancer_id: ``str``

     :param rule_id: the unique identifier for the rule.
     :type rule_id: ``str``

     :rtype: JSON


   .. rb:method:: wait_for()

     Polls the load balancer until an "ACTIVE" state is returned.  Use this when chaining actions.

     :rtype: ``nil``