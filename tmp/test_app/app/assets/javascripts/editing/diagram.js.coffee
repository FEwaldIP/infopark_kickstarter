$ ->
  template = (attributes) ->
    attributes ||= {}

    name = attributes['name'] || ''
    value = attributes['value'] || ''

    $("<li>
         <input type=\"text\" name=\"name\" value=\"#{name}\" placeholder=\"Title\" />
         <input type=\"text\" name=\"value\" value=\"#{value}\" placeholder=\"Value\" class=\"editing-value\" />
         <div class=\"actions\">
           <a href=\"#\" class=\"editing-button add-value editing-green\">
             <i class=\"editing-icon editing-icon-add\" />
           </a>
           <a href=\"#\" class=\"editing-button editing-red delete\">
             <i class=\"editing-icon editing-icon-trash\" />
           </a>
         </div>
       </li>")

  # parse the serialized list-entry elements
  parse = (string)->
    data = []

    for attributes in string.split('|')
      [name, value] = attributes.split(',')

      if !!name && !!value
        data.push({
          name: name,
          value: value
        })

    data

  # serialize the list-entry elements
  serialize = (elements)->
    chunks = []

    for element in elements
      name = $(element).find('[name="name"]').val()
      value = $(element).find('[name="value"]').val()
      chunks.push("#{name},#{value}")

    chunks.join('|')

  # Returns the closest linklist DOM element.
  getCmsField = ->
    $('.editing.diagramm_widget')

  # returns the list element
  getListElement = ->
    getCmsField().find('ul')

  # returns the element that holds the serialized data
  getSerialzeDataElement = ->
    getCmsField().find('[data-ip-field-name="data"]')

  # assign event handler to the elements
  assignHandlers = (element) ->
    element.on 'click', '.add-value', addElement
    element.on 'click', '.delete', removeElement
    element.on 'focusout', 'input', save

  # add an empty element to the list
  addEmptyElement = ->
    element = template()

    getListElement().append(element)
    assignHandlers(element)

  # add list-entry elements by the passed data [{name: 'name', value: '50'}, ...]
  addElements = (data) ->
    for attributes in data
      element = template()

      assignHandlers(element)
      getListElement().append(element)
      element.find('[name="name"]').val(attributes['name'])
      element.find('[name="value"]').val(attributes['value'])

  # add a new empty element to the list
  addElement = (event) ->
    event.preventDefault()

    content = $(event.currentTarget).closest('li')
    element = template()

    content.after(element)
    assignHandlers(element)

  # Removes an element from the list.
  removeElement = (event) ->
    event.preventDefault()

    content = $(event.currentTarget).closest('li')

    content.remove()
    save()

  # save the current elements
  save = ->
    elements = getListElement().find('li')
    getSerialzeDataElement().infopark('save', serialize(elements))

  # Initialize linklist editor and setup event callbacks.
  infopark.on 'new_content', (root) ->
    serialzedData = getSerialzeDataElement().text()
    data = parse(serialzedData)

    unless data.length == 0
      addElements(data)
    else
      addEmptyElement()


