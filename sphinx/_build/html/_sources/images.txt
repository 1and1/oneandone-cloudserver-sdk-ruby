Images
******

.. rb:class:: OneAndOne::Image()
   
   The :rb:class:`Image` class allows a user to perform actions against the 1and1 API.

   
    .. rb:method:: create(server_id: nil, name: nil, description: nil, frequency: nil, num_images: nil)

      Create a new image.

      :param server_id: the ID of the server to be copied.
      :type server_id: ``str``

      :param name: image name.
      :type name: ``str``

      :param description: image description.
      :type description: ``str``

      :param frequency: image creation policy.  Possible values are ``'ONCE'``, ``'DAILY'``, and ``'WEEKLY'``.
      :type frequency: ``str``

      :param num_images: the number of images to create.
      :type num_images: ``int``

      :rtype: JSON


    .. rb:method:: modify(image_id: @id, name: nil, description: nil, frequency: nil)

      Modify an image.

      :param image_id: the unique identifier for the image.
      :type image_id: ``str``

      :param name: image name.
      :type name: ``str``

      :param description: image description.
      :type description: ``str``

      :param frequency: can only be changed to ``'ONCE'``
      :type frequency: ``str``

      :rtype: JSON


    .. rb:method:: delete(image_id: @id)

      Delete an image.

      :param image_id: the unique identifier for the image.
      :type image_id: ``str``

      :rtype: JSON


    .. rb:method:: get(image_id: @id)

      Retrieve an image's current specs.

      :param image_id: the unique identifier for the image.
      :type image_id: ``str``

      :rtype: JSON


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



    .. rb:method:: wait_for()

      Polls the image until an "ACTIVE" state is returned.  Use this when chaining actions.

      :rtype: ``nil``