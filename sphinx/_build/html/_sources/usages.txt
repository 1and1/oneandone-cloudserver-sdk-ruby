Usages
*****************

.. rb:class:: OneAndOne::Usage()
   
   The :rb:class:`Usage` class allows a user to perform actions against the 1and1 API.


   .. rb:method:: list(page: nil, per_page: nil, sort: nil, q: nil, fields: nil, period: 'LAST_24H', start_date: nil, end_date: nil)

     List all usages by time period.

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

     :param period: the time range of logs to be shown.  Possible values are 
        ``'LAST_HOUR'``, ``'LAST_24H'``, ``'LAST_7D'``, ``'LAST_30D'``, 
        ``'LAST_365D'``, or ``'CUSTOM'``
     :type period: ``str``

     :param start_date: start point.  Only required if using ``'CUSTOM'`` for the 
        ``period`` parameter.  *Format:* ``2015-19-05T00:05:00Z``
     :type start_date: ``str``

     :param end_date: end point.  Only required if using ``'CUSTOM'`` for the 
        ``period`` parameter.  *Format:* ``2015-19-05T00:10:00Z``
     :type end_date: ``str``

     :rtype: JSON