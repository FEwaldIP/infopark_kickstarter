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

  decode = ->
    string = getDataElement().text()
    model = []

    if !!string
      for data in string.split("|")
        nameValue = data.split(',')

        name = nameValue[0]
        value = nameValue[1]

        if !!name && !!value
          model.push({
            name: name,
            value: value
          })

    model

  endcode = ->
    string = ''

    getCmsField().find('ul li').each ->
      if !!string
        string += "|"

      name = $(this).find('[name="name"]').val()
      value = $(this).find('[name="value"]').val()

      if !!name && !!value
        string += "#{name},#{value}"

    string

  # Returns the closest linklist DOM element.
  getCmsField = ->
    $('.editing.diagramm_widget')

  getDataElement = ->
    $(getCmsField().find('[data-ip-field-name="data"]'))

  # Adds a new field to the list.
  addField = (event) ->
    event.preventDefault()

    cmsField = $(event.currentTarget).closest('ul')
    content = $('<li>').html(template())

    cmsField.append(content)
    assignHandlers(content)

    content

  assignHandlers = (content) ->
    content.on 'click', '.add-value', addField
    content.on 'click', '.delete', removeField
    content.on 'focusout', 'input', save

  addEmptyField = ->
    content = $('<li>').html(template())

    getCmsField().find('ul').append(content)
    assignHandlers(content)

  addFilledFields = (datas) ->
    cmsField = getCmsField().find('ul')

    for data in datas
      content = $('<li>').html(template())
      cmsField.append(content)

      content.find('[name="name"]').attr('value', data['name'])
      content.find('[name="value"]').attr('value', data['value'])

      assignHandlers(content)

  # Removes a field from the list.
  removeField = (event) ->
    event.preventDefault()

    content = $(event.currentTarget).closest('li')

    content.remove()
    save()

  #
  save = ->
    getDataElement().infopark('save', endcode())

  # Initialize linklist editor and setup event callbacks.
  infopark.on 'new_content', (root) ->
    listElements = getCmsField().find('li')
    datas = decode()

    if datas.length == 0
      addEmptyField()
    else
      addFilledFields(datas)


