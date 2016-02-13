Monitoring Policies
*****************

.. rb:class:: OneAndOne::MonitoringPolicy()
   
   The :rb:class:`MonitoringPolicy` class allows a user to perform actions against the 1and1 API.


   .. rb:method:: list(page: nil, per_page: nil, sort: nil, q: nil, fields: nil)

     Return a list of all monitoring policies.

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


   .. rb:method:: create(name: nil, description: nil, email: nil, agent: nil, thresholds: nil, ports: nil, processes: nil)

      Create a monitoring policy.

      :param name: monitoring policy name.
      :type name: ``str``

      :param description: monitoring policy description.
      :type description: ``str``

      :param email: user's email.
      :type email: ``str``

      :param agent: set true for using agent.
      :type agent: ``bool``

      :param thresholds: a "thresholds hash" that sets warning and critical limits for ``cpu``, ``ram``, ``disk``, ``transfer``, and ``internal_ping``.
      :type thresholds: ``hash``

      :param ports: an array of "port hashes".
      :type ports: ``array``

      :param processes: an array of "process hashes".
      :type processes: ``array``

      :rtype: JSON


   .. rb:method:: get(monitoring_policy_id: @id)

     Returns a monitoring policy's current specs.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :rtype: JSON


   .. rb:method:: modify(monitoring_policy_id: @id, name: nil, description: nil, email: nil, thresholds: nil)

     Modify a monitoring policy.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param name: monitoring policy name.
     :type name: ``str``

     :param description: monitoring policy description.
     :type description: ``str``

     :param email: user's email.
     :type email: ``str``

     :param thresholds: a "thresholds hash" that sets warning and critical limits for ``cpu``, ``ram``, ``disk``, ``transfer``, and ``internal_ping``.
     :type thresholds: ``hash``

     :rtype: JSON


   .. rb:method:: delete(monitoring_policy_id: @id)

     Delete a monitoring policy.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :rtype: JSON


   .. rb:method:: ports(monitoring_policy_id: @id)

     List a monitoring policy's ports.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :rtype: JSON


   .. rb:method:: add_ports(monitoring_policy_id: @id, ports: nil)

     Add ports to a monitoring policy.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param ports: an array of "port hashes".
     :type ports: ``array``

     :rtype: JSON


   .. rb:method:: port(monitoring_policy_id: @id, port_id: nil)

     Returns information about a monitoring policy's port.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param port_id: the unique identifier for the port.
     :type port_id: ``str``

     :rtype: JSON


   .. rb:method:: modify_port(monitoring_policy_id: @id, port_id: nil, new_port: nil)

     Modify a monitoring policy's port.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param port_id: the unique identifier for the port.
     :type port_id: ``str``

     :param new_port: takes a "port hash",
     :type new_port: ``hash``

     :rtype: JSON


   .. rb:method:: delete_port(monitoring_policy_id: @id, port_id: nil)

     Delete a monitoring policy's port.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param port_id: the unique identifier for the port.
     :type port_id: ``str``

     :rtype: JSON


   .. rb:method:: processes(monitoring_policy_id: @id)

     List a monitoring policy's processes.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :rtype: JSON


   .. rb:method:: process(monitoring_policy_id: @id, process_id: nil)

     Returns information about a monitoring policy's process.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param process_id: the unique identifier for the process.
     :type process_id: ``str``

     :rtype: JSON


   .. rb:method:: add_processes(monitoring_policy_id: @id, processes: nil)

     Add processes to a monitoring policy.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param processes: an array of "process hashes".
     :type processes: ``array``

     :rtype: JSON


   .. rb:method:: modify_process(monitoring_policy_id: @id, process_id: nil, new_process: nil)

     Modify a monitoring policy's process.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param process_id: the unique identifier for the process.
     :type process_id: ``str``

     :param new_process: takes a "process hash",
     :type new_process: ``hash``

     :rtype: JSON


   .. rb:method:: delete_process(monitoring_policy_id: @id, process_id: nil)

     Delete a monitoring policy's process.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param process_id: the unique identifier for the process.
     :type process_id: ``str``

     :rtype: JSON


   .. rb:method:: servers(monitoring_policy_id: @id)

     List a monitoring policy's servers.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :rtype: JSON


   .. rb:method:: server(monitoring_policy_id: @id, server_id: nil)

     Returns information about a monitoring policy's server.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param server_id: the unique identifier for the server.
     :type server_id: ``str``

     :rtype: JSON


   .. rb:method:: add_servers(monitoring_policy_id: @id, servers: nil)

     Add servers to a monitoring policy.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param servers: an array of server ID strings.
     :type servers: ``array``

     :rtype: JSON


   .. rb:method:: remove_server(monitoring_policy_id: @id, server_id: nil)

     Remove a server from a monitoring policy.

     :param monitoring_policy_id: the unique identifier for the monitoring policy.
     :type monitoring_policy_id: ``str``

     :param server_id: the unique identifier for the server.
     :type server_id: ``str``

     :rtype: JSON


   .. rb:method:: wait_for()

     Polls the monitoring policy until an "ACTIVE" state is returned.  Use this when chaining actions.

     :rtype: ``nil``