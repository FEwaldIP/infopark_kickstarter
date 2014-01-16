$ ->
  template = (attributes) ->
    attributes ||= {}

    name = attributes['name'] || ''
    value = attributes['value'] || ''

    $("<input type=\"text\" name=\"name\" value=\"#{name}\" placeholder=\"Title\" />
       <input type=\"text\" name=\"value\" value=\"#{value}\" placeholder=\"Value\" class=\"editing-value\" />
       <div class=\"actions\">
         <a href=\"#\" class=\"editing-button add-value editing-green\">
           <i class=\"editing-icon editing-icon-add\" />
         </a>
         <a href=\"#\" class=\"editing-button editing-red delete\">
           <i class=\"editing-icon editing-icon-trash\" />
         </a>
       </div>")

  parse = ->
    elements = []
    string = getDataElement().text()

    for data in string.split('|')
      [name, value] = data.split(',')

      if !!name && !!value
        elements.push({
          name: name,
          value: value
        })

    elements

  serialize = ->
    elements = []

    getCmsField().find('ul li').each ->
      name = $(this).find('[name="name"]').val()
      value = $(this).find('[name="value"]').val()

      elements.push("#{name},#{value}")

    elements.join('|')

  # Returns the closest linklist DOM element.
  getCmsField = ->
    $('.editing.diagramm_widget')

  getDataElement = ->
    $(getCmsField().find('[data-ip-field-name="data"]'))

  assignHandlers = (element) ->
    element.on 'click', '.add-value', addEmptyElement
    element.on 'click', '.delete', removeField
    element.on 'focusout', 'input', save

  addEmptyElement = ->
    element = $('<li>').html(template())
    list = getCmsField().find('ul')

    list.append(element)
    assignHandlers(element)

  addElements = (items) ->
    list = getCmsField().find('ul')

    for item in items
      element = $('<li>').html(template())
      list.append(element)

      element.find('[name="name"]').val(item['name'])
      element.find('[name="value"]').val(item['value'])

      assignHandlers(element)

  # Removes a field from the list.
  removeField = (event) ->
    event.preventDefault()

    content = $(event.currentTarget).closest('li')

    content.remove()
    save()

  #
  save = ->
    getDataElement().infopark('save', serialize())

  # Initialize linklist editor and setup event callbacks.
  infopark.on 'new_content', (root) ->
    items = parse()

    unless items.length == 0
      addElements(items)
    else
      addEmptyElement()


