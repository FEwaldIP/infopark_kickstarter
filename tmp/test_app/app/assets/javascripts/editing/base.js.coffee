$ ->
  # The "editing" event is only fired, when an editable working copy is selected. The callback
  # allows different styling based on whether the published or an editable working copy is selected.

  infopark.on 'editing', ->
    $('body').addClass('ip_editable_workspace')


  # Activate or deactivate in-place editing.
  #
  # Click on the pen marker to activate in-place editing,
  # click on the menu item 'Deactivate in-place editing' to deactivate it.

  $('a#edit-toggle').on 'click', ->
    if infopark.gui.is_open()
      infopark.gui.close()
    else
      infopark.gui.open()


  # Define available filters for the mediabrowser.
  #
  # Each filter is composed of a name, a title, an icon and a search query that gets executed, when
  # the filter is activated. The icon is a CSS class used to describe a font icon. If the icon is
  # omitted a generic icon is used. Look at the various editors that open the media browser for more
  # details on how to restrict the available list of filters by using their name.
  #
  # Examples:
  #
  # Creates a filter that only displays all objects that have the object class "Image".
  #   {
  #     images: {
  #       title: 'Images',
  #       icon: 'editing-icon-image',
  #       query: infopark.obj_where('_obj_class', 'equals', 'Image')
  #     }
  #   }
  Mediabrowser.filters = ->
    'images':
      title: 'Images'
      query: infopark.obj_where('_obj_class', 'equals', 'Image')
      icon: 'editing-icon-image'
    'videos':
      title: 'Videos'
      query: infopark.obj_where('_obj_class', 'equals', 'Video')
    'error_pages':
      title: 'Error Pages'
      query: infopark.obj_where('_obj_class', 'equals', 'ErrorPage')
